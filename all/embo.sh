#!/bin/sh

# extract only the urls (http://people.embo.org/profile/christine-a-orengo) from the html at http://people.embo.org
saxon -o:embo.txt embo.xml -xsl:embo.xsl
