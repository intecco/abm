<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:udt="http://umi-cms.ru/2007/UData/templates" xmlns:umi="http://www.umi-cms.ru/TR/umi" exclude-result-prefixes="xsl date udt umi">

	<xsl:template match="result[@module = 'faq'][@method = 'post_question']">
		<xsl:variable name="postedPage" select="document('upage://51')/udata/page" />
		<div class="ml40">
			<h2 class="mt30 mb30" umi:element-id="51" umi:field-name="h1" >
			<xsl:value-of select="$postedPage//property[@name='h1']/value" />
		</h2>
			<div class="content-block" umi:element-id="51" umi:field-name="content" >
				<xsl:value-of select="$postedPage//property[@name='content']/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>

</xsl:stylesheet>