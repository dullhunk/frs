<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY crlf "&#xA0;">
]>
<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs"
		version="2.0">

		<xsl:output method="text"/>


		<xsl:template match="html">
			<html>
			<xsl:apply-templates/>
		</html>
		</xsl:template>

		<xsl:template match="xhtml:title"/>

		<xsl:template match="xhtml:a">
			<xsl:value-of select="@href"/>
			<!--xsl:text>&crlf;</xsl:text-->
			<xsl:text>&#10;</xsl:text>
		</xsl:template>



</xsl:stylesheet>
