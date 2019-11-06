#!/bin/sh

YEAR=$1

# create editable text file for wiki-text
saxon -o:$YEAR.txt frs-all.xml -xsl:all.xsl YEAR=$YEAR
# create html with search links
saxon -o:$YEAR.html frs-all.xml -xsl:alltohtml.xsl YEAR=$YEAR
