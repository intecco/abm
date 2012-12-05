<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Footer content -->
	<xsl:template name="footerContent">
		<xsl:variable name="contactPage" select="document('udata://custom/getPageId/112')/udata/page" />
		<xsl:variable name="vk" select="document(concat('upage://',$contactPage/@id,'.vkontakte'))/udata/property/value" />
		<xsl:variable name="fc" select="document(concat('upage://',$contactPage/@id,'.facebook'))/udata/property/value" />
		<xsl:variable name="tw" select="document(concat('upage://',$contactPage/@id,'.twitter'))/udata/property/value" />
		
		<xsl:call-template name="copyright" />
		<ul class="social-links ib ml60">
			<li class="ib">
				<a href="{$vk}" class="vk"></a>
			</li>
			<li class="ib">
				<a href="{$fc}" class="fb"></a>
			</li>
			<li class="ib">
				<a href="{$tw}" class="tw"></a>
			</li>
		</ul>
		<a href="http://www.intecco.ru/" class="dev fr ib" target="__blank">Разработка сайта</a>
	</xsl:template>

	<xsl:template name="copyright">
		<xsl:variable name="contactPage" select="document('udata://custom/getPageId/111')/udata/page" />
		<xsl:variable name="cont" select="document(concat('upage://',$contactPage/@id,'.footer_copyright'))/udata/property/value" />
		<xsl:if test="$cont!=''">
			<div class="fl" umi:element-id="{$contactPage/@id}" umi:field-name="footer_copyright" umi:empty="&empty-page-content;">
				<xsl:value-of select="$cont" disable-output-escaping="yes" />
                                <a href="/razdel_dlya_dilerov/">Информация для дилеров</a>
			</div>
		</xsl:if>
	</xsl:template>
	<!--### END Footer content -->

</xsl:stylesheet>