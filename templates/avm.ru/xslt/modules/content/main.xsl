<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Main page -->
	<xsl:template match="/result[page/@is-default=1]" priority="1">

		<!-- slider -->
		<xsl:apply-templates select="document('udata://content/getSlider/')/udata" mode="mainSlider" />
		<!-- end slider -->

		<ul class="bonus-widget ml40">
			<li class="ib">
				<a href="/novelty" class="new">
					<xsl:text>Новинки</xsl:text>
				</a>
			</li>
			<li class="ib">
				<a href="/special_offers" class="special-propouses">
					<xsl:text disable-output-escaping="yes">Специальные&lt;br /&gt;предложения</xsl:text>
				</a>
			</li>
			<li class="ib lc">
				<a href="/credit" class="credits">
					<xsl:text>Кредит</xsl:text>
				</a>
			</li>
		</ul>
	</xsl:template>

	<!-- slider -->
	<xsl:template match="udata" mode="mainSlider">
		<xsl:if test="total &gt; 0">
			<div class="slideshow ml54 mb20">
				<a class="backward ib"></a>
				<div class="images">
					<xsl:apply-templates select="items/item" mode="sliderItem" />
				</div>
				<a class="forward ib"></a>

				<div class="slidetabs">
					<xsl:for-each select="items/item">
						<a href="#"></a>
					</xsl:for-each>
				</div>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="item" mode="sliderItem">
	<xsl:variable name="imgSrc" select="document(concat('upage://',@id,'.slider_img'))//property/value"/>
		<div class="slide">
		<img src="{$imgSrc}"/>
				<h1 class="ml60 mt10">
					<xsl:value-of select="@title" />
				</h1>
				<p class="ml60 mt10">
					<xsl:value-of select="." disable-output-escaping="yes" />
				</p>
		</div>
	</xsl:template>
	<!--### END Main page -->


</xsl:stylesheet>