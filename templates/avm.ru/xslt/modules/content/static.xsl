<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Static page -->
	<xsl:template match="/result[@method='content']">
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			<div class="content-block" umi:element-id="{$document-page-id}" umi:field-name="content">
				<xsl:value-of select=".//property[@name='content']/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>
	<!--### END Static page -->
	
	
</xsl:stylesheet>