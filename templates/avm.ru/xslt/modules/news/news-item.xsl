<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">

	<xsl:template match="/result[@module = 'news'][@method = 'item']">
		<div class="ml40">
			<h2 class="mt30 mb20" umi:element-id="{$document-page-id}" umi:field-name="h1" umi:empty="&empty-page-date;">
				<xsl:value-of select=".//property[@name='h1']/value" />
			</h2>
			<span class="date mb10" umi:element-id="{$document-page-id}" umi:field-name="publish_time" umi:empty="&empty-page-date;">
				<xsl:apply-templates select=".//property[@name = 'publish_time']" />
			</span>
			<xsl:call-template name="catalog-thumbnail">
				<xsl:with-param name="element-id" select="page/@id" />
				<xsl:with-param name="field-name">
					<xsl:text>publish_pic</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="width">
					<xsl:text>209</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="height">
					<xsl:text>164</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="class">
					<xsl:text>imageborder fl mr20 mb10</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
			<div class="news-content" umi:element-id="{$document-page-id}" umi:field-name="title_custom" umi:empty="&empty-page-content;">
				<xsl:value-of select=".//property[@name='title_custom']/value" disable-output-escaping="yes" />
			</div>
			<div class="mt10" umi:element-id="{$document-page-id}" umi:field-name="content" umi:empty="&empty-page-content;">
				<xsl:value-of select=".//property[@name='content']/value" disable-output-escaping="yes" />
			</div>
			<a href="../" class="btn small-btn ib mt30">
				<img src="{$template-resources}images/white-back.gif" alt="" />
				Вернуться к списку новостей
			</a>
		</div>
	</xsl:template>


</xsl:stylesheet>