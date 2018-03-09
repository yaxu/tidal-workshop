#!/bin/bash

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

pandoc -s 0*.md --template=templates/template.latex --from markdown+auto_identifiers -V colorlinks --number-sections --pdf-engine=xelatex --variable mainfont="Brill" --bibliography all.bib --filter render.hs -o pihkal.pdf
