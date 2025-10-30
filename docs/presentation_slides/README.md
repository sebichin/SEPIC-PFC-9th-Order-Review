# HTML Presentation Slides: 9th-Order SEPIC PFC Converter

## Overview

This directory contains a complete HTML presentation covering the derivation and analysis of the 9th-order interleaved bridgeless SEPIC PFC converter. The presentation consists of 16 professionally styled slides that detail all 36 differential equations across the four switching topologies.

## Slide Contents

### Part 1: Introduction (Slides 1-2)
- **Slide 01**: Title Slide - Project overview and key information
- **Slide 02**: System Overview - 9th-order system definition, state vector, and four topologies

### Part 2: Per-Topology Equations (Slides 3-7)
- **Slide 03**: Topology 11 - Both Switches ON (9 equations)
- **Slide 04**: Topology 10 - S1 ON, S2 OFF (9 equations)
- **Slide 05**: Topology 01 - S1 OFF, S2 ON (9 equations)
- **Slide 06**: Topology 00 - Both Switches OFF (9 equations)
- **Slide 07**: Summary Table - All 36 equations in compact format

### Part 3: Circuit Analysis Insights (Slides 8-10)
- **Slide 08**: Direct Charging Paths - Critical insight into input inductor operation
- **Slide 09**: Output Inductor Modes - Storage vs. Transfer operation
- **Slide 10**: Capacitor Roles - Energy staging and CPL effects

### Part 4: Mathematical Framework (Slides 11-13)
- **Slide 11**: State-Space Form - Matrix representation
- **Slide 12**: Averaging Methodology - From discrete to continuous model
- **Slide 13**: Linearization - Small-signal analysis for control design

### Part 5: Conclusion (Slides 14-16)
- **Slide 14**: Verification Status - Validation checklist
- **Slide 15**: Conclusions and Future Work - Key achievements and next steps
- **Slide 16**: References and Acknowledgments

## How to View the Slides

### Option 1: Index Page (Recommended)
1. Open `index.html` in your web browser
2. Click on any slide card to view that slide
3. Use browser back button to return to index
4. Navigate through all 16 slides with easy access

### Option 2: Direct Viewing
1. Navigate to this directory in your file browser
2. Open any `slide_XX_*.html` file in a web browser (Chrome, Firefox, Safari, Edge)
3. Each slide is self-contained and can be viewed independently

### Option 3: Sequential Viewing
Open slides in numerical order (01 through 16) for a complete presentation flow:
```
slide_01_title.html
slide_02_system_overview.html
slide_03_topology_11_equations.html
...
slide_16_references_acknowledgments.html
```

## Presentation Display

The slides are designed for:
- **Resolution**: 1280×720 pixels (16:9 aspect ratio)
- **Full-screen mode**: Press F11 in most browsers for immersive presentation
- **Zoom**: Use browser zoom (Ctrl/Cmd + +/-) if needed for larger displays

## Styling Features

All slides maintain consistent professional styling:
- **Background**: Deep blue (#1e3a5f)
- **Primary text**: White (#ffffff)
- **Accent headers**: Orange (#f39c12)
- **Equation boxes**: Blue gradient with border (#3498db)
- **Note sections**: Orange gradient (#f39c12)
- **Typography**: Roboto font family for body, Courier New for equations

## Source Attribution

### Equations Source
All 36 equations are sourced from:
- **Primary**: `docs/detailed_analysis/COMPLETE_36_EQUATION_DERIVATION.md`

### Context and Explanations
Pedagogical context and physical interpretations from:
- `STUDENT_GUIDE.md` - Foundations and circuit theory
- `MASTER_CONSOLIDATION.md` - Research consolidation and standards

### Styling Template
Visual design based on:
- `docs/example_slide.html` - Reference template with exact color scheme and layout

## Technical Details

### HTML Structure
- Valid HTML5 with proper DOCTYPE and meta tags
- Responsive design at fixed 1280×720 dimensions
- External CDN resources for Tailwind CSS and Google Fonts
- Inline CSS for custom styling and layout

### Equations Format
- HTML subscripts (`<sub>`) and superscripts (`<sup>`) for mathematical notation
- Monospace font (Courier New) for equation display
- Consistent spacing and alignment
- Proper mathematical symbols (·, ², ³, etc.)

### Browser Compatibility
Tested and compatible with:
- Google Chrome 90+
- Mozilla Firefox 88+
- Safari 14+
- Microsoft Edge 90+

## File Naming Convention

Format: `slide_[NUMBER]_[DESCRIPTION].html`

Example: `slide_03_topology_11_equations.html`

## Verification

All equations have been verified against source documentation:
- ✅ Dimensional consistency checked
- ✅ Sign conventions maintained
- ✅ Physical interpretations validated
- ✅ Circuit topology correspondence confirmed

## Usage Notes

### For Presentations
1. Open Slide 01 in full-screen mode (F11)
2. Navigate through slides sequentially
3. Use presenter notes (from source documents) for detailed explanations
4. Pause on equation slides for audience comprehension

### For Documentation
- Each slide can serve as standalone documentation
- Equations can be copied (though HTML formatting may need adjustment)
- Screenshots can be taken for inclusion in reports

### For Study
- Review slides 3-7 for complete equation reference
- Study slides 8-10 for circuit operation insights
- Use slides 11-13 for mathematical modeling understanding

## Converting to PDF

### Overview

The slides can be converted to landscape-oriented PDF files for offline distribution, printing, and archival purposes. A Python script (`html_to_pdf_converter.py`) automates this process using Playwright for high-fidelity rendering.

### Installation

**Step 1: Install Python Dependencies**
```bash
cd docs/presentation_slides
pip install -r requirements_pdf.txt
```

**Step 2: Install Chromium Browser**
```bash
playwright install chromium
```

### Usage

**Convert All Slides to Individual PDFs:**
```bash
python html_to_pdf_converter.py
```

This creates 16 PDF files in the `pdf_output/` directory, maintaining landscape orientation (10in × 5.625in, 16:9 aspect ratio).

**Convert and Create Combined Presentation PDF:**
```bash
python html_to_pdf_converter.py --combined
```

This generates both individual PDFs and a single multi-page presentation file: `SEPIC_PFC_Complete_Presentation.pdf`

**Convert Specific Slides:**
```bash
python html_to_pdf_converter.py --slides slide_03 slide_07 slide_11
```

**Custom Output Directory:**
```bash
python html_to_pdf_converter.py --output-dir ./my_pdfs --combined
```

**Verbose Mode (Detailed Progress):**
```bash
python html_to_pdf_converter.py --verbose
```

### Command-Line Options

- `--output-dir <dir>` - Custom output directory (default: `pdf_output/`)
- `--combined` - Generate combined multi-page PDF
- `--combined-name <name>` - Custom name for combined PDF
- `--slides <list>` - Convert only specific slides (space-separated)
- `--verbose` - Print detailed progress and debugging info

### Output Quality

The PDF conversion preserves:
- ✅ Landscape orientation (16:9 aspect ratio)
- ✅ All colors and gradient backgrounds
- ✅ Roboto font family and Courier New for equations
- ✅ Mathematical notation (subscripts, superscripts, symbols)
- ✅ Exact layout and dimensions (1280×720px)
- ✅ CSS styling and formatting

### Troubleshooting

**Error: "Playwright not installed"**
```bash
pip install playwright
playwright install chromium
```

**Error: "PyPDF2 not installed" (only affects --combined feature)**
```bash
pip install PyPDF2
```

**Fonts not rendering correctly:**
- Ensure internet connection is active (Google Fonts loaded via CDN)
- Try using `--verbose` flag to see detailed loading information

**PDF file sizes too large:**
- Normal range: 100-500 KB per slide
- Large sizes indicate proper embedding of fonts and graphics

### Technical Details

- **Rendering Engine**: Chromium (via Playwright) for perfect HTML/CSS rendering
- **Page Size**: 10 inches × 5.625 inches (16:9 landscape)
- **Viewport**: 1280px × 720px
- **Resolution**: 96 DPI (screen resolution)
- **Color Space**: RGB
- **Font Embedding**: Automatic (Roboto from Google Fonts, Courier New system font)

## Related Documentation

For deeper understanding, refer to:
- `COMPLETE_36_EQUATION_DERIVATION.md` - Full mathematical derivations
- `STUDENT_GUIDE.md` - Comprehensive learning guide
- `MASTER_CONSOLIDATION.md` - Research findings and standards
- `example_slide.html` - Styling template reference

## Maintenance

To update slides:
1. Edit the HTML files directly
2. Maintain consistent styling (copy from existing slides)
3. Verify equations against source documents
4. Test in multiple browsers
5. Update this README if slide content or count changes

## Contact

**Project**: 9th-Order SEPIC PFC Converter Analysis  
**Repository**: github.com/sebichin/SEPIC.analysis.9th.order  
**Student**: Sebastian  
**Email**: sebastianchinsc@gmail.com

---

Last Updated: 2025  
Version: 1.0
