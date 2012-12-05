<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="/result[@method = 'object' and @module='catalog']" priority="1">
		<xsl:apply-templates select="document(concat('upage://',$document-page-id))/udata/page" mode="object-view" />

	</xsl:template>

	<xsl:template match="page" mode="object-view">

		<xsl:variable name="price" select=".//property[@name='price']/value" />
		<xsl:variable name="oldPrice" select=".//property[@name='old_price']/value" />
                <xsl:variable name="discount-price" select="document(concat('udata://emarket/price/',@id))/udata/price/actual" />
                <xsl:variable name="discount-price-original" select="document(concat('udata://emarket/price/',@id))/udata/price/original" />
                
                <xsl:variable name="formatDiscountPrice" select="document(concat('udata://custom/formatNumber/',$discount-price))/udata" />
		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
		<xsl:variable name="formatOldPrice" select="document(concat('udata://custom/formatNumber/',$oldPrice))/udata" />

		<form action="/udata/emarket/basket/put/element/{@id}/.json" id="addToCartForm">
			<input type="hidden" name="no-redirect" value='1' />
			<div class="ml40">
				<h2 class="mt30 mb30"><xsl:value-of select=".//property[@name='h1']/value" disable-output-escaping="yes" /></h2>
				<section class="mt30 full-good-card" umi:element-id="{$document-page-id}">
					<div class="ib first-column">
						<a href="#" class="gallery">
							<xsl:if test=".//property[@name='photo']/value!=''">
								<!--<xsl:attribute name="rel"><xsl:text>fancy-object</xsl:text></xsl:attribute>-->
								<xsl:attribute name="rel"><xsl:text></xsl:text>prettyPhoto[group]</xsl:attribute>
								<xsl:attribute name="href"><xsl:value-of select=".//property[@name='photo']/value" /></xsl:attribute>
							</xsl:if>
							<xsl:call-template name="catalog-thumbnail">
								<xsl:with-param name="element-id" select="@id" />
								<xsl:with-param name="field-name">
									<xsl:text>photo</xsl:text>
								</xsl:with-param>
								<xsl:with-param name="width">
									<xsl:text>373</xsl:text>
								</xsl:with-param>
								<xsl:with-param name="height">
									<xsl:text>266</xsl:text>
								</xsl:with-param>
							</xsl:call-template>
						</a>
						<xsl:apply-templates select=".//property[@name='colors']" mode="optionList" />

						<xsl:if test="count(.//group[@name='more_photos']/property) &gt; 0">
							<xsl:apply-templates select=".//group[@name='more_photos']/property" mode="morePhotos" />
						</xsl:if>

						<xsl:if test=".//property[@name='left_content']/value!=''">
							<div class="left_content"  umi:field-name="left_content">
								<xsl:value-of select=".//property[@name='left_content']/value" disable-output-escaping="yes" />
							</div>
						</xsl:if>
						<a href="../" class="btn small-btn ib mt30">
							<img src="{$template-resources}images/white-back.gif" alt="" />
							Вернуться в категорию
						</a>
					</div>

					<div class="ib second-column ml30">
						<div class="ib characteristic">
							<xsl:if test=".//property[@name='article']/value != '' or .//property[@name='artikul']/value != ''">
								<p class="mb10">
									<b class="ib mr10">Артикул</b>
									<span class="ib" umi:element-id="{$document-page-id}" umi:field-name="article">
										<xsl:choose>
											<xsl:when test=".//property[@name='article']/value != ''">
												<xsl:value-of select=".//property[@name='article']/value" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select=".//property[@name='artikul']/value" />
											</xsl:otherwise>
										</xsl:choose>
									</span>
								</p>
							</xsl:if>
							<xsl:apply-templates select=".//group[@name='uniq_property']/property" mode="objPagePropertyCommon" />
						</div>
						<xsl:if test="$oldPrice &gt; 0">
							<div class="old-price mt10">
								<s umi:field-name="old_price">
									<xsl:value-of select="concat($formatOldPrice,' руб.')" />
								</s>
							</div>
						</xsl:if>
                                                <xsl:if test="$discount-price-original">
<!--                                                    <p class="price mt30">
                                                        <s class="price mt30">
                                                        <xsl:value-of select="concat($formatPrice,' руб.')" />
                                                                          </s>
                                                    </p>-->
                                                    <p class="price mt30" umi:field-name="price">
                                                        <xsl:value-of select="concat($formatDiscountPrice,' руб.')" />
                                                    </p>
                                                </xsl:if>
                                                <xsl:if test="not($discount-price-original)">
						<p class="price mt30" umi:field-name="old_price">
							<xsl:value-of select="concat('Цена: ',$formatPrice,' руб.')" />
						</p> 
                                                
                                               
                                                </xsl:if>
						<p class="mb10">
							<b class="ib mr10">Наличие на складе</b>
							<span class="ib" umi:element-id="{$document-page-id}" umi:field-name="stock_isset">
								<xsl:choose>
									<xsl:when test=".//property[@name='common_quantity']/value &gt; 0">
										<xsl:text>Да</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test=".//property[@name='stock_isset']/value = '1'" >
												<xsl:text>Да</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>Нет</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</p>
						<a style="cursor:pointer" id="addToCart" class="btn large-btn mt20 ib" rel="{$document-page-id}">
							<img src="{$template-resources}images/bucket-ico.png" class="fl" alt="" />
							&#160;Добавить в корзину
							<xsl:if test="$cart_items/item[page/@id = $document-page-id]">
								<xsl:text> (</xsl:text>
								<xsl:value-of select="sum($cart_items/item[page/@id = $document-page-id]/amount)" />
								<xsl:text>)</xsl:text>
							</xsl:if>
						</a>

						<xsl:if test="document(concat('upage://',$document-page-id))//page/@type-id = '138' or document(concat('upage://',$document-page-id))//page/@type-id = '139'">
							<xsl:apply-templates select="document(concat('udata://emarket/checkIsInCompareList/',@type-id,'/',@id))/udata" mode="compareLink">
								<xsl:with-param name="pageId" select="@id" />
								<xsl:with-param name="type" select="@type-id" />
							</xsl:apply-templates>
						</xsl:if>
						
						<xsl:if test=".//property[@name='right_content']/value!=''">
							<div class="right_content" umi:element-id="{$document-page-id}" umi:field-name="right_content">
								<xsl:value-of select=".//property[@name='right_content']/value" disable-output-escaping="yes" />
							</div>
						</xsl:if>
					</div>

				</section>

				<xsl:apply-templates select=".//property[@name='simular']" mode="simular" />

			</div>
		</form>

	</xsl:template>

	<xsl:template match="property" mode="morePhotos">
		<a href="{value}" class="ib mt10 ml3 gallery" rel="prettyPhoto[group]">
			<xsl:call-template name="catalog-thumbnail">
				<xsl:with-param name="element-id" select="$document-page-id" />
				<xsl:with-param name="field-name" select="@name" />
				<xsl:with-param name="width">
					<xsl:text>84</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="height">
					<xsl:text>58</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
		</a>
	</xsl:template>


	<xsl:template match="property" mode="objPagePropertyCommon">
		<p class="mb10">
			<b class="ib mr10">
				<xsl:value-of select="title" />
			</b>
			<span class="ib" umi:element-id="{$document-page-id}" umi:field-name="{@name}">
				<xsl:apply-templates select="." mode="objPageProperty" />
			</span>
		</p>
	</xsl:template>

	<xsl:template match="property" mode="objPageProperty">
		<xsl:value-of select="value" />
	</xsl:template>

	<xsl:template match="property[@type='relation']" mode="objPageProperty">
		<xsl:apply-templates select="value/item" mode="propertyItem" />
	</xsl:template>

	<xsl:template match="item" mode="propertyItem">
		<xsl:value-of select="@name" />
	</xsl:template>

	<xsl:template match="property" mode="optionList">
		<xsl:if test="count(value/option) &gt; 0">
			<input type="hidden" name="options[{@name}]" id="colorInput" value="{value/option[position()=1]/object/@id}" />
			<div class="color-widget mt10 mb10">
				<b>
					<xsl:value-of select="concat(title,': ')" />
				</b>
				<ul class="ib">
					<xsl:apply-templates select="value/option" mode="optionObjPage" />
				</ul>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="option" mode="optionObjPage">
		<xsl:variable name="obj" select="document(concat('uobject://',object/@id))/udata/object" />
		<li class="ib">

			<a href="{object/@id}" class="colorProperty" title="{object/@name}" style="background:{$obj//property[@name='background']/value}">
				<xsl:if test="position() = 1">
					<xsl:attribute name="class"><xsl:text>active-color colorProperty</xsl:text></xsl:attribute>
				</xsl:if>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="property" mode="simular">
		<xsl:if test="count(value/page) &gt; 0">
			<section class="also mt30">
				<h3 class="mt20">С этим товаром также покупают</h3>

				<xsl:apply-templates select="value/page" mode="simularCart" />

			</section>
		</xsl:if>
	</xsl:template>

	<xsl:template match="page" mode="simularCart">
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata/page" />

		<xsl:variable name="price" select="$curr//property[@name='price']/value" />
		<xsl:variable name="oldPrice" select="$curr//property[@name='old_price']/value" />

		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
		<xsl:variable name="formatOldPrice" select="document(concat('udata://custom/formatNumber/',$oldPrice))/udata" />

		<div class="good-mini-card ib mb40 mt20" umi:element-id="{@id}">
			<h3>
				<a href="{$curr/@link}">
					<xsl:value-of select="$curr//property[@name='h1']/value" />
				</a>
			</h3>
			<div class="ib mt20 fc">
				<a href="{@curr/@link}">
					<xsl:call-template name="preResize">
						<xsl:with-param name="element-id" select="@id" />
						<xsl:with-param name="field-name">
							<xsl:text>photo</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="width">
							<xsl:text>122</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="height">
							<xsl:text>122</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="class">
							<xsl:text>imageborder</xsl:text>
						</xsl:with-param>
					</xsl:call-template>

				</a>
				<xsl:if test="$oldPrice &gt; 0">
					<div class="mt10">
						<s>
							<xsl:value-of select="concat($formatOldPrice,' руб.')" />
						</s>
					</div>
				</xsl:if>
				<p class="price mt10">
					<xsl:value-of select="concat($formatPrice,' руб.')" />
				</p>

			</div>
			<div class="ib mt20 ml15 characteristic">
				<xsl:apply-templates select="document(concat('udata://catalog/getPropertyForMini/',@id))/udata/properties/property" mode="uniq_property" />
			</div>
			<br />

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
		</div>
	</xsl:template>

</xsl:stylesheet>