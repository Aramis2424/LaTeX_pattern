CODE_DIR = report
SLIDES_DIR = slides
RELEASE_DIR = release
MASTER_FILENAME = report

REPORT_MAIN = $(CODE_DIR)/$(MASTER_FILENAME).tex
SLIDES_PPTX = $(SLIDES_DIR)/slides.pptx

REPORT_PDF = $(RELEASE_DIR)/report.pdf
SLIDES_PDF = $(RELEASE_DIR)/slides.pdf

COMPRESSOR = ./compress.sh

LIBREOFFICE = libreoffice
LATEX = pdflatex
LATEX_FLAGS = -interaction=nonstopmode --shell-escape -halt-on-error -file-line-error
BIBLIOGRAPHY = biber

all: $(REPORT_PDF) $(SLIDES_PDF)

$(REPORT_PDF): $(REPORT_MAIN) $(wildcard $(CODE_DIR)/*.tex) $(wildcard $(CODE_DIR)/img/*)
	@mkdir -p $(RELEASE_DIR)
	cd $(CODE_DIR) && $(LATEX) $(LATEX_FLAGS) $(MASTER_FILENAME).tex
	cd $(CODE_DIR) && $(BIBLIOGRAPHY) $(MASTER_FILENAME)
	cd $(CODE_DIR) && $(LATEX) $(LATEX_FLAGS) $(MASTER_FILENAME).tex
	@cp $(CODE_DIR)/$(MASTER_FILENAME).pdf $(REPORT_PDF)
	chmod +x $(COMPRESSOR)
	$(COMPRESSOR) $(REPORT_PDF)
	rm -f $(RELEASE_DIR)/*.backup

$(SLIDES_PDF): $(SLIDES_PPTX)
	$(LIBREOFFICE) --headless --convert-to pdf --outdir $(RELEASE_DIR) $(SLIDES_PPTX)
	chmod +x $(COMPRESSOR)
	$(COMPRESSOR) $(SLIDES_PDF)
	rm -f $(RELEASE_DIR)/*.backup

clean:
	rm -rf $(RELEASE_DIR)
	cd $(CODE_DIR) && rm -f *.aux *.log *.out *.toc *.pdf *.gz

.PHONY: all clean
