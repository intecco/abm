<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="result[@method = 'category' and @module='auto']">
<xsl:variable name="retr" select="document('udata://auto/category/')/udata" />
<xsl:value-of select="$retr" disable-output-escaping="yes"/>

	</xsl:template>
	
	<xsl:template match="result[@method = 'detail' and @module='auto']">
<xsl:variable name="retr" select="document('udata://auto/detail/')/udata" />
<xsl:value-of select="$retr" disable-output-escaping="yes"/>

	</xsl:template>

</xsl:stylesheet>