<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#xA0;">
	<!ENTITY crlf "&#10;">
]>
<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		version="2.0">
		<xsl:output method="html"/>
		<xsl:param name="YEAR" as="xs:integer" required="yes"/>

		<xsl:template match="/">
			<xsl:apply-templates/>
		</xsl:template>

		<xsl:template match="fellows">
			<html><ol>
			<xsl:for-each select="p">
				<!-- this explains the abbreviations for elements, e, f, s etc-->
				<!-- the next best thing to an XML schema or DTD data model-->

				<xsl:variable name="first-names" select="normalize-space(f)"/>
				<xsl:variable name="second-names" select="normalize-space(s)"/>
				<xsl:variable name="member-status" select="normalize-space(m)"/>
				<xsl:variable name="year-of-birth" select="number(normalize-space(b))" />
				<xsl:variable name="year-of-death" select="number(normalize-space(d))" />
				<xsl:variable name="year-elected" select="number(normalize-space(e))" />

				<xsl:if test="$year-elected = $YEAR">
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://www.google.co.uk/search?q=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$second-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$year-of-birth"/>
						</xsl:attribute>
						<xsl:value-of select="$first-names"/>
						<xsl:text>&nbsp;</xsl:text>
						<xsl:value-of select="$second-names"/>
						<xsl:text>&nbsp;</xsl:text>
						<xsl:value-of select="$year-of-birth"/>
					</a>
					<!--xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://www.google.co.uk/search?q=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$second-names"/>
							<xsl:text>&nbsp;rsbm</xsl:text>
						</xsl:attribute>
						<xsl:text>rsbm</xsl:text>
					</a-->
					<!--xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://www.google.co.uk/search?q=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$second-names"/>
							<xsl:text>&nbsp;odnb</xsl:text>
						</xsl:attribute>
						<xsl:text>odnb</xsl:text>
					</a-->
					<!--xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>http://ukwhoswho.com/search/quick?quicksearch=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>+</xsl:text>
							<xsl:value-of select="$second-names"/>
						</xsl:attribute>
						<xsl:text>whoswho</xsl:text>
					</a-->

					<xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://www.wikidata.org/w/index.php?search=&amp;search=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$second-names"/>
						</xsl:attribute>
						<xsl:text>wikidata</xsl:text>
					</a>

					<xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://www.scopus.com/results/authorNamesList.uri?origin=searchauthorlookup&amp;advancedTab=</xsl:text>
							<xsl:text>&amp;st1=</xsl:text>
							<xsl:value-of select="$second-names"/>
							<xsl:text>&amp;st2=</xsl:text>
							<xsl:value-of select="$first-names"/>
						</xsl:attribute>
						<xsl:text>Scopus</xsl:text>
					</a>

					<!--xsl:text>&nbsp;·&nbsp;</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:text>https://scholar.google.co.uk/scholar?q=</xsl:text>
							<xsl:value-of select="$first-names"/>
							<xsl:text>&nbsp;</xsl:text>
							<xsl:value-of select="$second-names"/>
						</xsl:attribute>
						<xsl:text>scholar</xsl:text>
					</a-->

				</li>
				</xsl:if>
			</xsl:for-each>
		</ol></html>
		</xsl:template>


</xsl:stylesheet>
