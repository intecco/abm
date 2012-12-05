<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START News list page -->
	<xsl:template match="/result[@module = 'news'][@method = 'rubric']">
		<!-- content/menu.xsl -->
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			
			<xsl:apply-templates select="document(concat('udata://news/lastlist/',$document-page-id,'/notemplate/////(end_time)/0'))" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@method = 'lastlist']">
		<ul class="content-list" umi:element-id="{$document-page-id}" umi:region="list" umi:module="news" umi:method="lastlist" umi:sortable="sortable">
			<xsl:apply-templates select="items/item" mode="news-list" />
		</ul>
		<xsl:apply-templates select="total" />
	</xsl:template>


	<xsl:template match="item" mode="news-list">
		<xsl:variable name="curr" select="document(concat('upage://', @id))" />
		<li umi:element-id="{@id}" umi:region="row">
			<div class="ib">
				<xsl:call-template name="catalog-thumbnail">
					<xsl:with-param name="element-id" select="@id" />
					<xsl:with-param name="field-name">
						<xsl:text>anons_pic</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="width">
						<xsl:text>91</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="height">
						<xsl:text>60</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="class">
						<xsl:text>imageborder</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<div class="ib txt">
				<span class="date mb5" umi:field-name="publish_time" umi:empty="&empty-page-date;">
					<xsl:apply-templates select="$curr//property[@name = 'publish_time']" />
				</span>
				<a href="{@link}" umi:field-name="name" umi:delete="delete" umi:empty="&empty-page-name;">
					<xsl:value-of select="." />
				</a>
				<div class="mt10" umi:field-name="anons" umi:empty="&empty-page-anons;">
					<xsl:value-of select="$curr//property[@name = 'anons']/value" disable-output-escaping="yes" />
				</div>
			</div>
		</li>
	</xsl:template>
	<!--### END News list page -->
</xsl:stylesheet>