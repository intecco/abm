<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Section page -->
	<xsl:template match="/result[@method = 'category' and @module='catalog']">
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />

			<xsl:if test="document(concat('upage://',$document-page-id,'.use_filter'))//value = '1'">
                            
				<xsl:apply-templates select="document('udata://catalog/search_custom')" mode="catalogFilter" />

			</xsl:if>
			<!-- content/menu.xsl -->
			<xsl:call-template name="subCatalogMenu" />

			<!-- catalog/search-filter.xsl -->
                        <xsl:if test="document(concat('udata://catalog/getObjectsListCustom/notemplate/',$document-page-id,'/5'))/udata/total &gt; 0" >
                            <xsl:call-template name="sortBlock" />
                        </xsl:if>

			<xsl:apply-templates select="document(concat('udata://catalog/getObjectsListCustom/notemplate/',$document-page-id))/udata" mode="objList" />

		</div>
	</xsl:template>


	<xsl:template match="udata[@method='getObjectsListCustom']" mode="objList">

		<section class="mt30 goods-area">

			<xsl:choose>
				<xsl:when test="total &gt; 0">
					<xsl:apply-templates select="lines/item" mode="catalogItem" />
				</xsl:when>
				<xsl:otherwise>
					<div class="good-card ib mr20 mb40">
						<!--<xsl:text>В данной категории нет товаров.</xsl:text>-->
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</section>
		<xsl:apply-templates select="total" />
	</xsl:template>

	<xsl:template match="item|page" mode="catalogItem">
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata/page" />
		<xsl:variable name="price" select="$curr//property[@name='price']/value" />
                <xsl:variable name="discount-price" select="document(concat('udata://emarket/price/',@id))/udata/price/actual" />
                <xsl:variable name="discount-price-original" select="document(concat('udata://emarket/price/',@id))/udata/price/original" />
		<xsl:variable name="oldPrice" select="$curr//property[@name='old_price']/value" />

		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
                <xsl:variable name="formatDiscountPrice" select="document(concat('udata://custom/formatNumber/',$discount-price))/udata" />
		<xsl:variable name="formatOldPrice" select="document(concat('udata://custom/formatNumber/',$oldPrice))/udata" />



		<div class="good-card ib mr10 mb40" umi:element-id="{@id}">
			<h3>
				<a href="{$curr/@link}" umi:field-name="h1">
					<xsl:value-of select="$curr/name" />
				</a>
			</h3>
			<div class="ib mt20 fc">
				<xsl:if test="$curr//property[@name='novelty']/value">
					<div class="new-ico"></div>
				</xsl:if>
				<a href="{$curr/@link}">
					<xsl:call-template name="preResize">
						<xsl:with-param name="element-id" select="@id" />
						<xsl:with-param name="field-name">
							<xsl:text>photo</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="width">
							<xsl:text>162</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="height">
							<xsl:text>162</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="class">
							<xsl:text>imageborder</xsl:text>
						</xsl:with-param>
					</xsl:call-template>
				</a>
				<xsl:if test="$oldPrice &gt; 0">
					<s class="old-price mt10" umi:field-name="old_price">
						<xsl:value-of select="concat($formatOldPrice,' руб.')" />
					</s>
				</xsl:if>
                                <xsl:if test="$discount-price-original">
<!--					<s class="price mt10">
						<xsl:value-of select="concat($formatPrice,' руб.')" />
					</s>-->
                                        <p class="price mt10" umi:field-name="price">
                                        <xsl:value-of select="concat($formatDiscountPrice,' руб.')" /></p>
				</xsl:if>
                                <xsl:if test="not($discount-price-original)">
				<p class="price mt10" umi:field-name="price">
					<xsl:value-of select="concat($formatPrice,' руб.')" />
				</p>
                                </xsl:if>
				<a href="/udata/emarket/basket/put/element/{@id}/.json?no-redirect=1" class="btn large-btn mt10 ib addToCartButton" rel="{@id}">
					<xsl:call-template name="byWithDefColor">
						<xsl:with-param name="pageId" select="@id" />
					</xsl:call-template>
					<img src="{$template-resources}images/bucket-ico.png" class="fl" alt="" />
					<xsl:text>&#160;Добавить
					в корзину</xsl:text>
					<xsl:if test="$cart_items/item[page/@id = $curr/@id]">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="sum($cart_items/item[page/@id = $curr/@id]/amount)" />
						<xsl:text>)</xsl:text>
					</xsl:if>
				</a>
				<xsl:if test="document(concat('upage://',@id))//page/@type-id = '138' or document(concat('upage://',@id))//page/@type-id = '139'">
					<xsl:apply-templates select="document(concat('udata://emarket/checkIsInCompareList/',$curr/@type-id,'/',@id))/udata" mode="compareLink">
						<xsl:with-param name="pageId" select="@id" />
						<xsl:with-param name="type" select="$curr/@type-id" />
					</xsl:apply-templates>
				</xsl:if>

			</div>

			<div class="ib mt20 ml5 characteristic">
				<xsl:apply-templates select="document(concat('udata://catalog/getPropertyForMini/',@id))/udata/properties/property" mode="uniq_property" />
			</div>
		</div>
	</xsl:template>


	<xsl:template match="udata" mode="compareLink">
		<xsl:param name="pageId" />
		<xsl:param name="type" />
		<xsl:param name="class" />
		<xsl:choose>
			<xsl:when test="result=1">
				<a href="/udata/emarket/toggleCompareList/{$pageId}/{$class}" class="add-to-compare mt10 mb10{$class}">Удалить из сравнения</a>
			</xsl:when>
			<xsl:otherwise>
				<a href="/udata/emarket/toggleCompareList/{$pageId}/{$class}" class="add-to-compare mt10 mb10{$class}">Добавить к сравнению</a>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="not($class)">
			<a href="{$comparePage/@link}?product_type={$type}">
				<xsl:value-of select="$comparePage/name" />
			</a>
		</xsl:if>
	</xsl:template>

	<xsl:template match="property" mode="uniq_property">
		<p class="mb10">
			<b class="ib mr10">
				<xsl:value-of select="@prop_title" />
			</b>
			<span class="ib" umi:field-name="{@prop_name}">
				<xsl:choose>
					<xsl:when test="count(value_item) &gt; 0">
						<xsl:apply-templates select="value_item" mode="uniq_property_array" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>

			</span>
		</p>
	</xsl:template>

	<xsl:template match="value_item" mode="uniq_property_array">
		<xsl:value-of select="." />
		<xsl:if test="position()!=last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<!--### END Section page -->

	<xsl:template name="byWithDefColor">
		<xsl:param name="pageId" />
		<xsl:variable name="curr" select="document(concat('upage://',$pageId,'.colors'))/udata/property/value" />
		<xsl:if test="count($curr/option) &gt; 0">
			<xsl:attribute name="href"><xsl:value-of select="concat('/udata/emarket/basket/put/element/',$pageId,'/.json?no-redirect=1&amp;options[colors]=',$curr/option[position()=1]/object/@id)" /></xsl:attribute>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>