#
# Build a PDF with all the notebooks 
#
#TEMPLATE=chapter
NOTEBOOKS=introduccion.ipynb \
	  accesodatos.ipynb \
          otros_lenguajes.ipynb \
          ejercicio_dados.ipynb

LATEXFILES=$(NOTEBOOKS:.ipynb=.tex)

CLEANFILES=$(.aux=.tex=.out=.log=.pdf)

#.ipynb.tex:
#	ipython nbconvert --to latex --template $(TEMPLATE) $<
#    ipython nbconvert --to latex $<

#all: $(LATEXFILES) buildpdf
all: latexfiles buildpdf

latexfiles:
	ipython nbconvert --to latex introduccion.ipynb
	ipython nbconvert --to latex git.ipynb
	ipython nbconvert --to latex generacion.ipynb
	ipython nbconvert --to latex accesodatos.ipynb
	ipython nbconvert --to latex otros_lenguajes.ipynb
	ipython nbconvert --to latex ejercicio_dados.ipynb
	

buildpdf: latexfiles
	pdflatex introduccion.tex
	pdflatex git.tex
	pdflatex generacion.tex
	pdflatex accesodatos.tex
	pdflatex otros_lenguajes.tex
	pdflatex ejercicio_dados.tex
	octave octave_1.m
	pdflatex ./matweave/myexample		
	pdfjoin introduccion.pdf git.pdf generacion.pdf accesodatos.pdf otros_lenguajes.pdf ./matweave/myexample.pdf ejercicio_dados.pdf 
	evince ejercicio_dados-joined.pdf
	
clean:
	rm -f *.aux
	rm -f *.tex
	rm -f *.out
	rm -f *.log
	rm -f *.pdf

