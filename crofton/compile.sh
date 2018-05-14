#!/bin/bash

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

pandoc -s 0*.md --from markdown+auto_identifiers -V colorlinks --number-sections --filter render.hs --latex-engine=xelatex -o tidal.pdf
