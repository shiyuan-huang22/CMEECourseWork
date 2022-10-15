#!/bin/bash
if [ -z "$1" ] ;then #If user did not enter a file name
  echo "Oops! Please enter a file name"
else
  if [ -f "$1" ]; then #If file entered exists
 
    if [[ $1 == *.tex ]] ;then #If user entered .tex file

      x=${1%.tex}
      pdflatex $x.tex
      bibtex $x.aux
      pdflatex $x.tex
      pdflatex $x.tex
      evince $x.pdf &

    # Cleanup
      rm *.aux
      rm *.log
      rm *.bbl
      rm *.blg

    else
      echo "Please enter a .tex file"
    fi

  else
     echo "Warning! Please enter a existing file"
  fi

fi

