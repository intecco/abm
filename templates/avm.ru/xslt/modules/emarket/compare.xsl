<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="/result[@method='content' and page/@alt-name='compare']" priority="1">
		<xsl:variable name="itemsList" select="document('udata://emarket/printCompareTable/')/udata" />
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />

			<table class="stripe-table">

				<xsl:choose>
					<xsl:when test="$itemsList/total &gt; 0">
						<tr>
							<td></td>
							<xsl:apply-templates select="$itemsList/items/item" mode="photoList" />
						</tr>

						<xsl:value-of select="$itemsList/items_html" disable-output-escaping="yes" />

						<tr>
							<td></td>
							<xsl:apply-templates select="$itemsList/items/item" mode="addToCartCompare" />
						</tr>
						
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td colspan="5">
								<xsl:text>Список пуст</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</table>


		</div>
	</xsl:template>

	<xsl:template match="item" mode="photoList">
		<xsl:variable name="curr" select="document(concat('upage://',.))/udata/page" />
		<td>
			<a href="{$curr/@link}">
				<p class="mb10">
					<xsl:value-of select="$curr//property[@name='h1']/value" />
				</p>

				<xsl:call-template name="preResize">
					<xsl:with-param name="element-id" select="." />
					<xsl:with-param name="field-name">
						<xsl:text>photo</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="width">
						<xsl:text>70</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="height">
						<xsl:text>70</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</a>
		</td>
	</xsl:template>

	<xsl:template match="item" mode="addToCartCompare">
		<xsl:variable name="currId" select="." />
		<td>
			<a href="/udata/emarket/basket/put/element/{$currId}/.json?no-redirect=1" class="btn large-btn ib compareAddToCart" rel="{$currId}">
				<xsl:call-template name="byWithDefColor">
					<xsl:with-param name="pageId" select="$currId" />
				</xsl:call-template>
				В корзину
				<xsl:if test="$cart_items/item[page/@id = $currId]">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="sum($cart_items/item[page/@id = $currId]/amount)" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</a>
			<xsl:apply-templates select="document(concat('udata://emarket/checkIsInCompareList/',$product_type,'/',$currId))/udata" mode="compareLink">
				<xsl:with-param name="pageId" select="$currId" />
				<xsl:with-param name="type" select="$product_type" />
				<xsl:with-param name="class">
					<xsl:text> comparePage</xsl:text>
				</xsl:with-param>
			</xsl:apply-templates>
		</td>
	</xsl:template>
</xsl:stylesheet>