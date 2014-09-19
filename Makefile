##
##  Na systemech podporujicich make (napr. Linux) lze celou prezentaci zkompilovat do PDF pomoci prikazu 
##  make
##  z konzole s pouzitim tohoto Makefile (po editaci promennych TARGET a SOURCE)
##
##  V menu rozsirenich LaTeXu je potreba pri tvorbe vysledneho PDF
##  pouzit posloupnost "klikatek":
##  1) LaTeX, ktere vytvori dvi
##  2) BibTeX, ktery vytvori seznam odkazu
##  3) 2x LaTeX, ktere zajisti vygenerovani spravnych krizovych referenci vcetne odkazu na literaturu
##  2) dvips, ktere dvi zkonvertuje do postscriptu (ps)
##  3) ps2pdf, ktere postscript zkonvertuje do pdf
##
##  pdflatex nebude fungovat (kvuli zahrnuti loga ve formátu eps)
##
##
TARGET = MgrPrace
SOURCE = $(TARGET).tex priklady_literatura.bib Mgr_titulni.tex Mgr_kap01.tex Mgr_kap02.tex Mgr_kap03.tex

all: $(TARGET).tex
	cslatex $(TARGET).tex
	bibtex $(TARGET)
	cslatex $(TARGET).tex
	cslatex $(TARGET).tex
	dvips -t a4 -o $(TARGET).ps $(TARGET).dvi
	ps2pdf $(TARGET).ps

pdf: $(TARGET).pdf
dvi: $(TARGET).dvi
ps: $(TARGET).ps

$(TARGET).pdf: $(TARGET).ps
	ps2pdf $(TARGET).ps

$(TARGET).ps: $(TARGET).dvi
	dvips -t a4 -o $(TARGET).ps $(TARGET).dvi

$(TARGET).dvi: $(SOURCE)
	cslatex $(TARGET).tex

clean:
	rm -f $(TARGET).ps $(TARGET).dvi $(TARGET).aux Mgr_titulni.aux Mgr_kap00.aux Mgr_kap01.aux Mgr_kap02.aux Mgr_kap03.aux $(TARGET).blg $(TARGET).bbl $(TARGET).log $(TARGET).out $(TARGET).lof $(TARGET).lot $(TARGET).toc 
