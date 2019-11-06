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
		<xsl:output method="text"/>
		<xsl:param name="YEAR" as="xs:integer" required="yes"/>

		<xsl:template match="/">
			<xsl:apply-templates/>
		</xsl:template>

		<xsl:template match="fellows">
			<!-- this is the header-->
			<xsl:text>[[Fellows of the Royal Society]] elected in </xsl:text>
			<!-- year parameter passed in from the command line-->
			<xsl:value-of select="$YEAR"/>
			<xsl:text>.&lt;ref&gt;{{cite web|archiveurl=https://web.archive.org/web/20150316060617/https://royalsociety.org/about-us/fellowship/fellows/|archivedate=2015-03-16|url=https://royalsociety.org/about-us/fellowship/fellows/|publisher=[[Royal Society]]|location=London|title=Fellows of the Royal Society}}&lt;/ref&gt;&lt;ref&gt;{{cite web|title=Fellowship of the Royal Society 1660-2015|url=https://docs.google.com/spreadsheets/d/1RVVZY00MZNrK2YCTTzVrbTFH2t3RxoAZah128gQR-NM/pubhtml|publisher=[[Royal Society]]|archiveurl=http://www.webcitation.org/6a2i9QICV|archivedate=2015-07-15}}&lt;/ref&gt;&crlf;</xsl:text>
			<!-- end of header-->
			<xsl:text>==Fellows of the Royal Society (FRS)==&crlf;</xsl:text>
			<xsl:text>{{colbegin||35em}}&crlf;</xsl:text>
			<xsl:text></xsl:text>
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
				<xsl:text>#&nbsp;</xsl:text>
				<xsl:value-of select="$first-names"/>
				<xsl:text>&nbsp;</xsl:text>
				<xsl:value-of select="$second-names"/>
				<xsl:choose>
					<xsl:when test="$year-of-birth and $year-of-death">
						<!--when we have both year of birth AND death-->
						<xsl:text>&nbsp;(</xsl:text>
						<xsl:value-of select="$year-of-birth"/>
						<xsl:text>-</xsl:text>
						<xsl:value-of select="$year-of-death"/>
						<xsl:text>)</xsl:text>
					</xsl:when>
					<xsl:when test="$year-of-birth">
						<!--when we only have year of birth-->
						<xsl:text>&nbsp;(</xsl:text>
						<xsl:text>born </xsl:text>
						<xsl:value-of select="$year-of-birth"/>
						<xsl:text>)</xsl:text>
					</xsl:when>
					<xsl:when test="$year-of-death">
						<!--when we only have year of death-->
						<xsl:text>&nbsp;(</xsl:text>
						<xsl:text>died </xsl:text>
						<xsl:value-of select="$year-of-death"/>
						<xsl:text>)</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- just put carriage return line feed -->
						<xsl:text>&crlf;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$member-status != 'frs'">
					<xsl:text>&nbsp;</xsl:text>
					<xsl:value-of select="$member-status"/>
				</xsl:if>
				<xsl:text>&crlf;</xsl:text>
			</xsl:if>
			</xsl:for-each>
			<xsl:text>{{colend}}&crlf;</xsl:text>
			<xsl:text>==Foreign Members of the Royal Society (ForMemRS)==&crlf;</xsl:text>
			<xsl:text>{{colbegin||35em}}&crlf;</xsl:text>
			<xsl:text>Cut and paste as appropriate&crlf;</xsl:text>
			<xsl:text>{{colend}}&crlf;</xsl:text>
			<!--footer-->
			<xsl:text>==References==&crlf;</xsl:text>
			<xsl:text>{{reflist|35em}}&crlf;</xsl:text>
			<xsl:text>&crlf;</xsl:text>
			<xsl:text>{{Fellows of the Royal Society}}&crlf;</xsl:text>
			<xsl:text>[[Category:</xsl:text>
			<xsl:value-of select="$YEAR"/>
			<xsl:text>&nbsp;in science]]</xsl:text>
			<xsl:text>&crlf;</xsl:text>
			<xsl:text>[[Category:Lists of Fellows of the Royal Society by year|</xsl:text>
			<xsl:value-of select="$YEAR"/>
			<xsl:text>]]&crlf;</xsl:text>
			<xsl:text>[[Category:</xsl:text>
			<xsl:value-of select="$YEAR"/>
			<xsl:text>&nbsp;in the United Kingdom]]&crlf;</xsl:text>
			<xsl:text>{{DEFAULTSORT:Fellows of the Royal Society elected in </xsl:text>
			<xsl:value-of select="$YEAR"/>
			<xsl:text>}}&crlf;</xsl:text>

		</xsl:template>


</xsl:stylesheet>
