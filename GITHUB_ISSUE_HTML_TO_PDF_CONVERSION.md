# GitHub Issue: Create Python Script to Convert HTML Slides to Landscape PDF

---

## 📋 Issue Title
**[AUTOMATION] Python Script: Convert 16 HTML Presentation Slides to Landscape-Mode PDF Files**

---

## 🎯 Issue Type
**Type:** Automation/Tooling  
**Priority:** P2 (Medium - Improves Workflow)  
**Labels:** `automation`, `pdf-generation`, `python`, `documentation`, `presentation`

---

## 📖 Executive Summary

**Objective:** Create a Python script that automatically converts all 16 HTML presentation slides (located in `docs/presentation_slides/`) into individual PDF files in **landscape orientation** (1280×720px, 16:9 aspect ratio).

**Context:** We have successfully generated a complete 16-slide HTML presentation covering the 9th-order SEPIC PFC converter mathematical derivation. Each slide is styled professionally and renders correctly in browsers. To facilitate offline distribution, printing, and archival purposes, we need PDF versions of all slides.

**Goal:** Develop a Python script (`html_to_pdf_converter.py`) that:
- Converts all 16 HTML slides to individual PDF files
- Maintains landscape orientation (16:9 aspect ratio)
- Preserves styling, fonts, colors, and mathematical notation
- Outputs PDFs with proper naming convention (e.g., `slide_01_title.pdf`)
- Optionally combines all PDFs into a single multi-page presentation PDF
- Provides clear progress output and error handling

---

## 📚 Input Files

### HTML Slides Directory:
**Location:** `docs/presentation_slides/`

**Files to Convert (16 slides):**
1. `slide_01_title.html`
2. `slide_02_system_overview.html`
3. `slide_03_topology_11_equations.html`
4. `slide_04_topology_10_equations.html`
5. `slide_05_topology_01_equations.html`
6. `slide_06_topology_00_equations.html`
7. `slide_07_summary_all_36_equations.html`
8. `slide_08_direct_charging_insight.html`
9. `slide_09_output_inductor_modes.html`
10. `slide_10_capacitor_roles.html`
11. `slide_11_state_space_form.html`
12. `slide_12_averaging_methodology.html`
13. `slide_13_linearization_control.html`
14. `slide_14_verification_status.html`
15. `slide_15_conclusions_future_work.html`
16. `slide_16_references_acknowledgments.html`

**Exclude from conversion:**
- `index.html` (navigation page, not a slide)
- `README.md` (documentation, not a slide)

---

## 🛠️ Technical Requirements

### Core Functionality:

**1. HTML to PDF Conversion**
- Use a reliable Python library for HTML rendering (recommended: `weasyprint`, `pdfkit`, or `playwright`)
- Maintain all CSS styling, web fonts (Roboto from Google Fonts), and mathematical notation
- Preserve exact layout and dimensions (1280px width × 720px height)

**2. Landscape Orientation**
- Set PDF page size to **landscape mode** with 16:9 aspect ratio
- Recommended page size: 10 inches × 5.625 inches (preserves 16:9 ratio) or custom 1280×720 points
- Ensure no content clipping or aspect ratio distortion

**3. Output File Naming**
- Convert `slide_XX_description.html` → `slide_XX_description.pdf`
- Maintain original filename structure for easy identification
- Output PDFs to: `docs/presentation_slides/pdf_output/` (create directory if not exists)

**4. Optional: Combined PDF**
- Create a single multi-page PDF: `SEPIC_PFC_Complete_Presentation.pdf`
- Concatenate all 16 slides in numerical order (slide_01 → slide_16)
- Place in: `docs/presentation_slides/SEPIC_PFC_Complete_Presentation.pdf`

**5. Progress Reporting**
- Print clear console output for each file being converted
- Show success/failure status with filename
- Display total conversion time and final summary

**6. Error Handling**
- Gracefully handle missing HTML files
- Report rendering errors without crashing the entire script
- Validate that web fonts and external resources load correctly

---

## 📐 Technical Implementation

### Recommended Technology Stack:

**Option A: WeasyPrint (Recommended for Quality)**
```python
# Pros: Pure Python, excellent CSS support, font rendering
# Cons: Requires GTK+ libraries on Windows (can be tricky)

from weasyprint import HTML, CSS

HTML('slide_01.html').write_pdf(
    'slide_01.pdf',
    stylesheets=[CSS(string='@page { size: 10in 5.625in; }')]
)
```

**Option B: pdfkit (wkhtmltopdf wrapper)**
```python
# Pros: Fast, widely used, good HTML rendering
# Cons: Requires external wkhtmltopdf binary installation

import pdfkit

options = {
    'page-width': '10in',
    'page-height': '5.625in',
    'orientation': 'Landscape',
    'enable-local-file-access': None
}

pdfkit.from_file('slide_01.html', 'slide_01.pdf', options=options)
```

**Option C: Playwright (Browser Automation)**
```python
# Pros: Perfect rendering (uses real Chromium), web font support
# Cons: Larger dependency (installs browser binary)

from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page(viewport={'width': 1280, 'height': 720})
    page.goto('file:///path/to/slide_01.html')
    page.pdf(path='slide_01.pdf', 
             width='10in', 
             height='5.625in', 
             landscape=True,
             print_background=True)
    browser.close()
```

**Recommendation:** Use **Playwright** for highest fidelity (guarantees web font loading and exact rendering), or **WeasyPrint** if pure-Python solution preferred.

---

## 📝 Script Requirements

### Script Name:
`html_to_pdf_converter.py`

### Location:
`docs/presentation_slides/html_to_pdf_converter.py`

### Command-Line Interface:
```bash
# Convert all slides to individual PDFs
python html_to_pdf_converter.py

# Convert all slides AND create combined PDF
python html_to_pdf_converter.py --combined

# Specify custom output directory
python html_to_pdf_converter.py --output-dir ./pdf_export

# Verbose mode with detailed progress
python html_to_pdf_converter.py --verbose

# Convert specific slide(s)
python html_to_pdf_converter.py --slides slide_03 slide_07
```

### Configuration Options:
- `--output-dir`: Custom output directory for PDFs (default: `pdf_output/`)
- `--combined`: Generate combined multi-page PDF in addition to individual files
- `--combined-name`: Custom name for combined PDF (default: `SEPIC_PFC_Complete_Presentation.pdf`)
- `--page-width`: Custom page width in inches (default: 10)
- `--page-height`: Custom page height in inches (default: 5.625)
- `--slides`: Convert only specific slides (space-separated list)
- `--verbose`: Print detailed progress and debugging info
- `--no-cleanup`: Keep temporary files for debugging

---

## 🎨 Quality Requirements

### Visual Fidelity:
1. **Color Accuracy:** All colors (#1e3a5f, #f39c12, #3498db, etc.) must render exactly as in HTML
2. **Font Rendering:** Roboto font family and Courier New for equations must render correctly
3. **Layout Preservation:** No clipping, overflow, or aspect ratio distortion
4. **Background Gradients:** CSS gradient backgrounds must render (not solid colors)
5. **Mathematical Notation:** Subscripts, superscripts, and symbols must be legible

### PDF Metadata:
```python
metadata = {
    'Title': 'Slide [NUMBER]: [DESCRIPTION]',
    'Author': 'sebichin',
    'Subject': '9th-Order SEPIC PFC Converter - Mathematical Derivation',
    'Keywords': 'SEPIC, PFC, Power Electronics, State-Space, Averaging',
    'Creator': 'html_to_pdf_converter.py',
    'Producer': 'Python + [Library Name]'
}
```

### File Size Optimization:
- Target: < 500 KB per slide (reasonable for vector graphics and embedded fonts)
- Use PDF compression where available
- Embed fonts subset (only characters used)

---

## 📋 Deliverables

### Primary Deliverables:

1. **Python Script:** `docs/presentation_slides/html_to_pdf_converter.py`
   - Complete, runnable script with all features
   - Well-commented code with docstrings
   - Follows PEP 8 style guidelines

2. **Requirements File:** `docs/presentation_slides/requirements_pdf.txt`
   - List all Python dependencies with versions
   - Example:
     ```
     playwright==1.40.0
     PyPDF2==3.0.1  # For combining PDFs
     ```

3. **README Documentation:** Update `docs/presentation_slides/README.md`
   - Add section: "Converting to PDF"
   - Installation instructions for dependencies
   - Usage examples with command-line options
   - Troubleshooting guide for common issues

4. **Output Directory:** `docs/presentation_slides/pdf_output/`
   - 16 individual PDF files (one per slide)
   - Optional: `SEPIC_PFC_Complete_Presentation.pdf` (combined)

### Supporting Deliverables:

5. **Installation Script (Optional):** `install_pdf_tools.sh` or `install_pdf_tools.bat`
   - Automate installation of system dependencies (e.g., wkhtmltopdf binary, GTK+ libraries)
   - Platform-specific (Windows/Linux/Mac)

6. **Test Script (Optional):** `test_pdf_conversion.py`
   - Verify all PDFs generated successfully
   - Check PDF page count, dimensions, and metadata
   - Report any rendering issues

---

## 🧠 Required Copilot Behavior Instructions

### Code Quality:
1. **Modular Design:** Separate concerns into functions:
   - `convert_html_to_pdf(html_path, pdf_path, options)`
   - `combine_pdfs(pdf_list, output_path)`
   - `validate_html_files(directory)`
   - `main()`

2. **Error Handling:** Use try-except blocks for:
   - File I/O errors (missing HTML files)
   - Rendering errors (CSS/font loading failures)
   - PDF generation errors (write permissions, disk space)

3. **Logging:** Use Python `logging` module:
   ```python
   import logging
   logging.basicConfig(level=logging.INFO, 
                       format='%(asctime)s - %(levelname)s - %(message)s')
   ```

4. **Type Hints:** Use Python type annotations for clarity:
   ```python
   def convert_html_to_pdf(html_path: str, pdf_path: str, 
                           options: dict) -> bool:
   ```

5. **Docstrings:** Document all functions with Google-style docstrings:
   ```python
   def convert_html_to_pdf(html_path, pdf_path, options):
       """
       Convert a single HTML file to PDF with specified options.
       
       Args:
           html_path (str): Path to input HTML file
           pdf_path (str): Path to output PDF file
           options (dict): Conversion options (page size, orientation, etc.)
           
       Returns:
           bool: True if conversion successful, False otherwise
           
       Raises:
           FileNotFoundError: If HTML file does not exist
           RuntimeError: If PDF rendering fails
       """
   ```

### Cross-Platform Compatibility:
1. **Path Handling:** Use `pathlib.Path` for cross-platform paths:
   ```python
   from pathlib import Path
   
   slides_dir = Path('docs/presentation_slides')
   pdf_output = slides_dir / 'pdf_output'
   pdf_output.mkdir(exist_ok=True)
   ```

2. **File URLs:** Use `file://` protocol for local file access:
   ```python
   from urllib.request import pathname2url
   
   file_url = 'file://' + pathname2url(str(html_path.resolve()))
   ```

3. **Dependencies:** Provide installation instructions for Windows, Linux, and macOS

### Performance:
1. **Parallel Processing (Optional):** Use `concurrent.futures` to convert multiple slides in parallel:
   ```python
   from concurrent.futures import ThreadPoolExecutor
   
   with ThreadPoolExecutor(max_workers=4) as executor:
       futures = [executor.submit(convert_html_to_pdf, html, pdf) 
                  for html, pdf in zip(html_files, pdf_files)]
   ```

2. **Progress Bar (Optional):** Use `tqdm` for visual progress:
   ```python
   from tqdm import tqdm
   
   for html_file in tqdm(html_files, desc="Converting slides"):
       convert_html_to_pdf(html_file, pdf_file)
   ```

---

## ✅ Success Criteria

This issue will be considered **RESOLVED** when:

1. ✅ **Script Created:** `html_to_pdf_converter.py` is fully functional
2. ✅ **All Slides Converted:** 16 individual PDF files generated successfully
3. ✅ **Landscape Orientation:** All PDFs are in 16:9 landscape mode (no portrait pages)
4. ✅ **Visual Quality:** Colors, fonts, gradients, and layout match HTML originals
5. ✅ **Mathematical Notation:** Equations render correctly with subscripts/superscripts
6. ✅ **Dependencies Documented:** `requirements_pdf.txt` lists all Python packages
7. ✅ **README Updated:** Installation and usage instructions added to `docs/presentation_slides/README.md`
8. ✅ **Error Handling:** Script handles missing files and rendering errors gracefully
9. ✅ **Command-Line Interface:** Supports options: `--combined`, `--output-dir`, `--verbose`, `--slides`
10. ✅ **Optional: Combined PDF:** Single multi-page PDF (`SEPIC_PFC_Complete_Presentation.pdf`) generated when `--combined` flag used

---

## 💬 Example Usage

### Basic Conversion (All Slides):
```bash
cd docs/presentation_slides
python html_to_pdf_converter.py
```

**Expected Output:**
```
[INFO] HTML to PDF Converter - Starting...
[INFO] Found 16 HTML slides to convert
[INFO] Output directory: pdf_output/
[INFO] Converting slide_01_title.html → slide_01_title.pdf ... OK (0.8s)
[INFO] Converting slide_02_system_overview.html → slide_02_system_overview.pdf ... OK (1.2s)
[INFO] Converting slide_03_topology_11_equations.html → slide_03_topology_11_equations.pdf ... OK (1.5s)
...
[INFO] Converting slide_16_references_acknowledgments.html → slide_16_references_acknowledgments.pdf ... OK (1.0s)
[INFO] ========================================
[INFO] Conversion Complete!
[INFO] Successfully converted: 16/16 slides
[INFO] Total time: 18.4 seconds
[INFO] Output location: docs/presentation_slides/pdf_output/
```

### With Combined PDF:
```bash
python html_to_pdf_converter.py --combined
```

**Additional Output:**
```
[INFO] Combining all PDFs into single presentation...
[INFO] Created: SEPIC_PFC_Complete_Presentation.pdf (16 pages, 4.2 MB)
```

### Convert Specific Slides:
```bash
python html_to_pdf_converter.py --slides slide_03 slide_07 --verbose
```

### Custom Output Directory:
```bash
python html_to_pdf_converter.py --output-dir ../pdf_export --combined-name My_Presentation.pdf
```

---

## 🔧 Installation & Setup

### Option A: Playwright (Recommended)

**Install Playwright:**
```bash
pip install playwright PyPDF2
playwright install chromium
```

**Why Playwright?**
- Perfect rendering using real Chromium browser engine
- Web fonts (Google Fonts) load automatically
- Exact CSS rendering (gradients, shadows, etc.)
- No external binary dependencies (self-contained)

### Option B: WeasyPrint

**Install WeasyPrint:**
```bash
pip install weasyprint PyPDF2
```

**Windows Note:** WeasyPrint requires GTK+ libraries. Install from:
- https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer

**Why WeasyPrint?**
- Pure Python solution
- Excellent CSS3 support
- Smaller dependency footprint

### Option C: pdfkit (wkhtmltopdf)

**Install pdfkit and wkhtmltopdf:**
```bash
pip install pdfkit PyPDF2

# Download wkhtmltopdf binary from:
# https://wkhtmltopdf.org/downloads.html
# Install to system PATH or specify path in script
```

**Why pdfkit?**
- Fast conversion speed
- Widely used and battle-tested
- Good HTML5/CSS3 support

---

## 📎 Reference Files

**HTML Slides Location:**
`docs/presentation_slides/slide_01.html` through `slide_16.html`

**Styling Reference:**
All slides use consistent styling:
- Background: `#1e3a5f`
- Fonts: Roboto (Google Fonts), Courier New (equations)
- Dimensions: 1280px × 720px
- TailwindCSS framework loaded via CDN

**Expected PDF Output:**
- Page size: 10 inches (width) × 5.625 inches (height) = 16:9 aspect ratio
- Orientation: Landscape
- Resolution: 96 DPI (default screen resolution)
- Color space: RGB

---

## 🎯 Priority and Timeline

**Priority Level:** 🟡 P2 - MEDIUM PRIORITY  
**Blocking:** None (enhancement for distribution)  
**Estimated Effort:** 2-3 hours (script development + testing)  
**Deadline:** Before final presentation distribution  

**Suggested Timeline:**
- **Hour 1:** Install dependencies, test rendering library with one slide
- **Hour 2:** Develop main conversion script with all features
- **Hour 3:** Test all 16 slides, fix rendering issues, optimize quality
- **Optional Hour 4:** Add combined PDF feature, parallel processing, progress bar

---

## 🚀 Bonus Features (Optional)

If time permits, consider adding:

1. **Batch Export to Different Formats:**
   - PNG images for embedding in documents
   - SVG vector exports (if library supports)

2. **Quality Presets:**
   - `--quality high`: 300 DPI, uncompressed (for printing)
   - `--quality medium`: 150 DPI, compressed (default)
   - `--quality low`: 96 DPI, heavily compressed (for email)

3. **Watermark Support:**
   - `--watermark "DRAFT"`: Add text watermark to all pages
   - `--watermark-image logo.png`: Add image watermark

4. **Thumbnail Generation:**
   - Create thumbnail images (200×112px) for quick preview

5. **Slide Notes Export:**
   - Extract any HTML comments as presenter notes in PDF

6. **Compare Before/After:**
   - Generate side-by-side comparison images (HTML screenshot vs. PDF page)

---

**Assigned to:** @copilot-agent  
**Repository:** https://github.com/sebichin/SEPIC.analysis.9th.order  
**Branch:** main (merged from `copilot/generate-html-presentation-slides`)  
**Labels:** `automation`, `pdf-generation`, `python`, `enhancement`  

---

END OF ISSUE
