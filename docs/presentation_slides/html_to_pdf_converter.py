#!/usr/bin/env python3
"""
HTML to PDF Converter for SEPIC PFC Presentation Slides

This script converts HTML presentation slides to landscape-oriented PDF files
using Playwright for high-fidelity rendering with proper web font support.

Author: sebichin
Repository: github.com/sebichin/SEPIC.analysis.9th.order
"""

import argparse
import logging
import sys
import time
from pathlib import Path
from typing import List, Tuple, Optional
from urllib.request import pathname2url

try:
    from playwright.sync_api import sync_playwright
except ImportError:
    print("ERROR: Playwright not installed. Install with: pip install playwright")
    print("After installing, run: playwright install chromium")
    sys.exit(1)

try:
    from PyPDF2 import PdfMerger
except ImportError:
    print("WARNING: PyPDF2 not installed. Combined PDF feature will be disabled.")
    print("Install with: pip install PyPDF2")
    PdfMerger = None


# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%H:%M:%S'
)
logger = logging.getLogger(__name__)


class HTMLToPDFConverter:
    """
    Converts HTML presentation slides to PDF files with auto-sizing.
    
    Uses Playwright (Chromium) for accurate rendering of CSS, web fonts, and
    mathematical notation. Automatically detects the actual content height
    and adjusts the PDF page size to capture all content without cutting off.
    """
    
    # Page width is fixed at 10 inches; height auto-adjusts based on content
    PAGE_WIDTH_INCHES = 10.0
    # Minimum page height (16:9 aspect ratio) - content can be taller
    PAGE_HEIGHT_INCHES = 5.625
    
    # Initial viewport size in pixels (1280×720, adjusts based on content)
    VIEWPORT_WIDTH = 1280
    VIEWPORT_HEIGHT = 720
    
    def __init__(self, slides_dir: Path, output_dir: Path, verbose: bool = False):
        """
        Initialize the converter.
        
        Args:
            slides_dir: Directory containing HTML slide files
            output_dir: Directory where PDF files will be saved
            verbose: Enable verbose logging
        """
        self.slides_dir = slides_dir.resolve()
        self.output_dir = output_dir.resolve()
        self.verbose = verbose
        
        if verbose:
            logger.setLevel(logging.DEBUG)
        
        # Ensure output directory exists
        self.output_dir.mkdir(parents=True, exist_ok=True)
        logger.info(f"Output directory: {self.output_dir}")
    
    def get_slide_files(self, specific_slides: Optional[List[str]] = None) -> List[Path]:
        """
        Get list of HTML slide files to convert.
        
        Args:
            specific_slides: Optional list of specific slide names to convert
                           Can be: 'slide_12', '12', 'slide_12_averaging_methodology', 
                           'slide_12_averaging_methodology.html', etc.
            
        Returns:
            List of Path objects for HTML files to convert
        """
        if specific_slides:
            # Convert specific slides
            slide_files = []
            for slide_name in specific_slides:
                found = False
                
                # Try exact match first (with .html extension)
                if slide_name.endswith('.html'):
                    slide_path = self.slides_dir / slide_name
                    if slide_path.exists():
                        slide_files.append(slide_path)
                        found = True
                else:
                    # Try adding .html extension
                    slide_path = self.slides_dir / f"{slide_name}.html"
                    if slide_path.exists():
                        slide_files.append(slide_path)
                        found = True
                    else:
                        # Try pattern matching: slide_12 matches slide_12_*.html
                        # or just '12' matches slide_12_*.html
                        if slide_name.startswith('slide_'):
                            pattern = f"{slide_name}_*.html"
                        elif slide_name.isdigit():
                            pattern = f"slide_{slide_name.zfill(2)}_*.html"
                        else:
                            pattern = f"slide_{slide_name}_*.html"
                        
                        matches = list(self.slides_dir.glob(pattern))
                        if matches:
                            slide_files.extend(matches)
                            found = True
                
                if not found:
                    logger.warning(f"Slide not found: {slide_name}")
                    logger.info(f"  Tried patterns: {slide_name}, {slide_name}.html, slide_{slide_name}_*.html")
        else:
            # Get all slide_XX_*.html files (exclude index.html)
            slide_files = sorted([
                f for f in self.slides_dir.glob("slide_*.html")
                if f.name != "index.html"
            ])
        
        return slide_files
    
    def convert_html_to_pdf(self, html_path: Path, pdf_path: Path, 
                           browser_context) -> bool:
        """
        Convert a single HTML file to PDF with auto-sizing to capture full content.
        
        Args:
            html_path: Path to input HTML file
            pdf_path: Path to output PDF file
            browser_context: Playwright browser context to reuse
            
        Returns:
            True if conversion successful, False otherwise
        """
        try:
            # Create a new page in the browser context
            page = browser_context.new_page()
            
            # Set initial viewport size with fixed width but flexible height
            page.set_viewport_size({
                'width': self.VIEWPORT_WIDTH,
                'height': self.VIEWPORT_HEIGHT
            })
            
            # Convert path to file URL
            file_url = 'file://' + pathname2url(str(html_path))
            
            if self.verbose:
                logger.debug(f"Loading: {file_url}")
            
            # Navigate to the HTML file
            page.goto(file_url, wait_until='networkidle', timeout=30000)
            
            # Wait a bit for any fonts to load
            page.wait_for_timeout(500)
            
            # Inject CSS to prevent page breaks and ensure single-page rendering
            page.add_style_tag(content="""
                * {
                    page-break-inside: avoid !important;
                    page-break-before: avoid !important;
                    page-break-after: avoid !important;
                    break-inside: avoid !important;
                }
                body, html {
                    overflow: visible !important;
                }
                .slide-container {
                    page-break-inside: avoid !important;
                    break-inside: avoid !important;
                }
            """)
            
            # Wait a moment for CSS to apply
            page.wait_for_timeout(100)
            
            # Get the actual content height by measuring the body or slide-container
            # This captures the full height of the content without cutting it off
            actual_height = page.evaluate("""
                () => {
                    const container = document.querySelector('.slide-container');
                    if (container) {
                        // Get the full scroll height of the container
                        return container.scrollHeight;
                    }
                    // Fallback to body if no container found
                    return document.body.scrollHeight;
                }
            """)
            
            if self.verbose:
                logger.debug(f"Detected content height: {actual_height}px")
            
            # Calculate the page height in inches based on actual content height
            # Use the same DPI ratio to maintain proper scaling
            # Standard viewport width is 1280px = 10 inches, so 1 inch = 128 pixels
            pixels_per_inch = self.VIEWPORT_WIDTH / self.PAGE_WIDTH_INCHES
            page_height_inches = actual_height / pixels_per_inch
            
            # Add extra padding (0.5 inches) to prevent any clipping at the bottom
            page_height_inches += 0.0
            
            # Ensure minimum height (use the original 16:9 height as minimum)
            page_height_inches = max(page_height_inches, self.PAGE_HEIGHT_INCHES)
            
            if self.verbose:
                logger.debug(f"PDF page height: {page_height_inches:.2f} inches")
            
            # Adjust viewport to match the content height for proper rendering
            if actual_height > self.VIEWPORT_HEIGHT:
                page.set_viewport_size({
                    'width': self.VIEWPORT_WIDTH,
                    'height': actual_height
                })
                # Wait a moment for the viewport change to take effect
                page.wait_for_timeout(200)
            
            # Generate PDF with dynamic height based on content
            # Keep width fixed at 10 inches, but height adjusts to content
            # Force single-page output by setting pageRanges and disabling page breaks
            page.pdf(
                path=str(pdf_path),
                width=f'{self.PAGE_WIDTH_INCHES}in',
                height=f'{page_height_inches}in',
                print_background=True,
                prefer_css_page_size=False,
                page_ranges='1',  # Only generate page 1 (forces single-page output)
                margin={
                    'top': '0',
                    'right': '0',
                    'bottom': '0',
                    'left': '0'
                }
            )
            
            page.close()
            return True
            
        except Exception as e:
            logger.error(f"Failed to convert {html_path.name}: {str(e)}")
            return False
    
    def convert_all_slides(self, specific_slides: Optional[List[str]] = None) -> Tuple[int, int]:
        """
        Convert all HTML slides to PDF.
        
        Args:
            specific_slides: Optional list of specific slide names to convert
            
        Returns:
            Tuple of (successful_count, total_count)
        """
        slide_files = self.get_slide_files(specific_slides)
        
        if not slide_files:
            logger.error("No HTML slide files found to convert")
            return 0, 0
        
        logger.info(f"Found {len(slide_files)} HTML slides to convert")
        
        successful = 0
        failed = 0
        
        # Launch browser once for all conversions
        logger.info("Launching browser...")
        with sync_playwright() as playwright:
            # Try to use system chromium if playwright's chromium is not available
            browser = None
            try:
                browser = playwright.chromium.launch(headless=True)
            except Exception as e:
                logger.debug(f"Could not launch playwright chromium: {e}")
                logger.info("Attempting to use system chromium...")
                
                # Try common chromium paths across different platforms
                common_chromium_paths = [
                    '/usr/bin/chromium-browser',  # Linux (Ubuntu/Debian)
                    '/usr/bin/chromium',          # Linux (Fedora/Arch)
                    '/usr/bin/google-chrome',     # Linux (Chrome)
                    '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',  # macOS
                    'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',    # Windows
                    'C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe'  # Windows 32-bit
                ]
                
                for chromium_path in common_chromium_paths:
                    if Path(chromium_path).exists():
                        try:
                            logger.debug(f"Trying: {chromium_path}")
                            browser = playwright.chromium.launch(
                                headless=True,
                                executable_path=chromium_path
                            )
                            logger.info(f"Using system browser: {chromium_path}")
                            break
                        except Exception as path_error:
                            logger.debug(f"Failed to launch {chromium_path}: {path_error}")
                            continue
                
                if browser is None:
                    logger.error("Could not find or launch any Chromium browser")
                    logger.error("Please install Playwright's browser with: playwright install chromium")
                    raise RuntimeError("No Chromium browser available")
            
            context = browser.new_context()
            
            for html_file in slide_files:
                pdf_file = self.output_dir / html_file.name.replace('.html', '.pdf')
                
                start_time = time.time()
                logger.info(f"Converting {html_file.name} → {pdf_file.name} ...")
                
                if self.convert_html_to_pdf(html_file, pdf_file, context):
                    elapsed = time.time() - start_time
                    file_size = pdf_file.stat().st_size / 1024  # KB
                    
                    # Verify page count if PyPDF2 is available
                    page_count = None
                    if PdfMerger is not None:
                        try:
                            from PyPDF2 import PdfReader
                            reader = PdfReader(str(pdf_file))
                            page_count = len(reader.pages)
                        except:
                            pass
                    
                    if page_count:
                        logger.info(f"  ✓ OK ({elapsed:.1f}s, {file_size:.1f} KB, {page_count} page{'s' if page_count != 1 else ''})")
                        if page_count > 1:
                            logger.warning(f"    ⚠ Multiple pages detected! Expected 1 page, got {page_count}")
                    else:
                        logger.info(f"  ✓ OK ({elapsed:.1f}s, {file_size:.1f} KB)")
                    
                    successful += 1
                else:
                    logger.error(f"  ✗ FAILED")
                    failed += 1
            
            context.close()
            browser.close()
        
        return successful, len(slide_files)
    
    def combine_pdfs(self, output_filename: str = "SEPIC_PFC_Complete_Presentation.pdf") -> bool:
        """
        Combine all individual PDF files into a single presentation PDF.
        
        Args:
            output_filename: Name for the combined PDF file
            
        Returns:
            True if successful, False otherwise
        """
        if PdfMerger is None:
            logger.error("PyPDF2 not installed. Cannot combine PDFs.")
            logger.error("Install with: pip install PyPDF2")
            return False
        
        try:
            # Get all PDF files in sorted order
            pdf_files = sorted(self.output_dir.glob("slide_*.pdf"))
            
            if not pdf_files:
                logger.error("No PDF files found to combine")
                return False
            
            logger.info(f"Combining {len(pdf_files)} PDFs into single presentation...")
            
            merger = PdfMerger()
            
            for pdf_file in pdf_files:
                if self.verbose:
                    logger.debug(f"Adding: {pdf_file.name}")
                merger.append(str(pdf_file))
            
            # Output path is in parent directory (presentation_slides/)
            output_path = self.slides_dir / output_filename
            merger.write(str(output_path))
            merger.close()
            
            file_size = output_path.stat().st_size / (1024 * 1024)  # MB
            logger.info(f"✓ Created: {output_filename} ({len(pdf_files)} pages, {file_size:.1f} MB)")
            logger.info(f"Location: {output_path}")
            
            return True
            
        except Exception as e:
            logger.error(f"Failed to combine PDFs: {str(e)}")
            return False


def parse_arguments() -> argparse.Namespace:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description='Convert HTML presentation slides to landscape-oriented PDF files',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Convert all slides to individual PDFs
  python html_to_pdf_converter.py
  
  # Convert all slides AND create combined PDF
  python html_to_pdf_converter.py --combined
  
  # Convert specific slides
  python html_to_pdf_converter.py --slides slide_03 slide_07
  
  # Specify custom output directory
  python html_to_pdf_converter.py --output-dir ./pdf_export
  
  # Verbose mode with detailed progress
  python html_to_pdf_converter.py --verbose
        """
    )
    
    parser.add_argument(
        '--output-dir',
        type=str,
        default='pdf_output',
        help='Output directory for PDF files (default: pdf_output/)'
    )
    
    parser.add_argument(
        '--combined',
        action='store_true',
        help='Generate combined multi-page PDF in addition to individual files'
    )
    
    parser.add_argument(
        '--combined-name',
        type=str,
        default='SEPIC_PFC_Complete_Presentation.pdf',
        help='Custom name for combined PDF (default: SEPIC_PFC_Complete_Presentation.pdf)'
    )
    
    parser.add_argument(
        '--slides',
        type=str,
        nargs='+',
        help='Convert only specific slides (space-separated list)'
    )
    
    parser.add_argument(
        '--verbose',
        action='store_true',
        help='Print detailed progress and debugging info'
    )
    
    return parser.parse_args()


def main():
    """Main entry point for the script."""
    args = parse_arguments()
    
    # Get the directory where this script is located
    script_dir = Path(__file__).parent.resolve()
    output_dir = script_dir / args.output_dir
    
    # Print header
    print("=" * 60)
    print("HTML to PDF Converter - SEPIC PFC Presentation Slides")
    print("=" * 60)
    
    # Create converter instance
    converter = HTMLToPDFConverter(
        slides_dir=script_dir,
        output_dir=output_dir,
        verbose=args.verbose
    )
    
    # Record start time
    start_time = time.time()
    
    # Convert slides
    successful, total = converter.convert_all_slides(args.slides)
    
    # Print summary
    print("=" * 60)
    if successful == total:
        logger.info(f"✓ Conversion Complete!")
    else:
        logger.warning(f"⚠ Conversion Completed with Errors")
    
    logger.info(f"Successfully converted: {successful}/{total} slides")
    
    elapsed_time = time.time() - start_time
    logger.info(f"Total time: {elapsed_time:.1f} seconds")
    logger.info(f"Output location: {output_dir}")
    
    # Combine PDFs if requested
    if args.combined and successful > 0:
        print("=" * 60)
        converter.combine_pdfs(args.combined_name)
    
    print("=" * 60)
    
    # Exit with appropriate code
    sys.exit(0 if successful == total else 1)


if __name__ == '__main__':
    main()
