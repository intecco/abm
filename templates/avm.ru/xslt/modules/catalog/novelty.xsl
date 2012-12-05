<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Novelty page -->
	<xsl:template match="/result[@method = 'content' and page/@alt-name='novelty']" priority="1">
		<xsl:variable name="productList" select="document(concat('usel://getSpecialItems/novelty/',$sort,'/',$limit,'/',$p))/udata" />
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			<!-- catalog/search-filter.xsl -->
			<xsl:call-template name="sortBlock" />
			<xsl:apply-templates select="$productList" mode="novelty" />
		</div>

	</xsl:template>

	<xsl:template match="udata" mode="novelty">
		<section class="mt30 goods-area">

			<xsl:choose>
				<xsl:when test="total &gt; 0">
					<xsl:apply-templates select="page" mode="catalogItem" />
				</xsl:when>
				<xsl:otherwise>
					<div class="good-card ib mr20 mb40">
						товаров нет
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</section>
		<xsl:apply-templates select="document(concat('udata://system/numpages/', total, '/', $limit))" />
	</xsl:template>
	<!--### END Novelty page -->



	<!--### START Special page -->
	<xsl:template match="/result[@method = 'content' and page/@alt-name='special_offers']" priority="1">
		<xsl:variable name="productList" select="document(concat('usel://getSpecialItems/special_offer/',$sort,'/',$limit,'/',$p))/udata" />
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			<!-- catalog/search-filter.xsl -->
			<xsl:call-template name="sortBlock" />
			<xsl:apply-templates select="$productList" mode="novelty" />
		</div>

	</xsl:template>
	<!--### START Special page -->

</xsl:stylesheet>