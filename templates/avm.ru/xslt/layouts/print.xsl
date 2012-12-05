<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="/" mode="layout">
		<xsl:variable name="order-info" select="document(concat('uobject://',$order_id))/udata" />
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>

		<html>

			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta name="keywords" content="{//meta/keywords}" />
				<meta name="description" content="{//meta/description}" />
				<meta name="author" content="" />
				<meta name="viewport" content="width=1024" />

				<title>
					<xsl:value-of select="$document-title" />
				</title>


				<script type="text/javascript" src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
				<script type="text/javascript" src="{$template-resources}js/default_value.js"></script>
				<script type="text/javascript" src="{$template-resources}js/script.js"></script>
				<script type="text/javascript" src="{$template-resources}js/custom.js"></script>
				<script type="text/javascript" src="{$template-resources}js/validation.js"></script>
				<script charset="utf-8" src="/js/site/__common.js?{/result/@system-build}" type="text/javascript"></script>
				<script type="text/javascript" src="{$template-resources}js/cusel-min.js"></script>
				<script type="text/javascript" src="{$template-resources}js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
				<script src="https://maps-api-ssl.google.com/maps/api/js?v=3&amp;sensor=true" type="text/javascript"></script>
				<script type="text/javascript" src="{$template-resources}js/google-map.js"></script>

				<link rel="stylesheet" href="{$template-resources}css/print.css" />

			</head>
			<body>
				<xsl:variable name="order" select="document(concat('uobject://',$order_id))/udata" />
				<xsl:variable name="customer_id" select="$order//property[@name='customer_id']/value/item/@id" />

				<xsl:if test="$user-id!=$customer_id">
					<xsl:apply-templates select="document('udata://content/redirect/(/)')/udata" />
				</xsl:if>

				<div class="order-single order-single-html">
					<div class="linksBlock">
						<a href="javascript: window.print()" class="print">Распечатать</a>
						<a href="/personal/orders/?show_order={$order_id}" class="back">Вернуться к обычной версии</a>
					</div>
					<table class="simple-table ib">

						<tr>
							<th>Товар</th>
							<th>Цена</th>
							<th>Кол-во</th>
							<th>Стоимость</th>


						</tr>
						<xsl:choose>
							<xsl:when test="count($order//group/property[@name='order_items']/value/item) &gt; 0">
								<xsl:apply-templates select="$order" mode="cartItemsOldPrint" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="document('udata://content/redirect/(/)')/udata" />
							</xsl:otherwise>
						</xsl:choose>
						
						  
                <tr>
					<!--<xsl:apply-templates select="$order-info" />-->

                 <p>Комментарий к заказу:              <xsl:value-of select="$order-info//property[@name='comment_order']/value" />     </p>
                 <p>Адрес доставки:        <xsl:value-of select="$user-info//property[@name='adres_dostavki']/value" />      </p>
                 <p>Контактный телефон: <xsl:value-of select="$order-info//property[@name='phone_user']/value" />           </p>
                </tr> 
					</table>


					<div class="shop-placement">
						<xsl:apply-templates select="$order//property[@name='store']" mode="storeBlock" />
					</div>
				</div>

			</body>
		</html>
	</xsl:template>



	<xsl:template match="properties" mode="cartItemsOldPrint">
		<xsl:apply-templates select=".//group/property[@name='order_items']/value/item" mode="cartItemsOldPrint" />
		<xsl:variable name="totalPrice" select=".//property[@name='total_price']/value" />
		<xsl:variable name="formatTotalPrice" select="document(concat('udata://custom/formatNumber/',$totalPrice))/udata" />
                

		<tr>
			<td colspan="4" class="lc">
				<p class="total mt10 mb10">
					<xsl:value-of select="concat('Итого ',$formatTotalPrice,' руб.')" />
				</p>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="item" mode="cartItemsOldPrint">

                <xsl:variable name="order-info" select="document(concat('uobject://',$order_id))/udata" />
                <xsl:variable name="currObj" select="document(concat('uobject://',@id))/udata" />
		<xsl:variable name="hierId" select="$currObj//property[@name='item_link']/value/page/@id" />
		<xsl:variable name="curr" select="document(concat('upage://',$hierId))/udata/page" />
		<xsl:variable name="article" select="$curr//property[@name='article']/value" />

		<xsl:variable name="price" select="$currObj//property[@name='item_price']/value" />
		<xsl:variable name="total-price" select="$currObj//property[@name='item_total_price']/value" />

		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
		<xsl:variable name="formatTotalPrice" select="document(concat('udata://custom/formatNumber/',$total-price))/udata" />
		<tr>
			<td class="good-item name">
				<a href="{$curr/@link}">
					<xsl:call-template name="preResize">
						<xsl:with-param name="element-id" select="$hierId" />
						<xsl:with-param name="field-name">
							<xsl:text>photo</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="width">
							<xsl:text>70</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="height">
							<xsl:text>70</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="class">
							<xsl:text>fl mr20</xsl:text>
						</xsl:with-param>
					</xsl:call-template>

				</a>
				<a href="{$curr/@link}">
					<xsl:value-of select="$curr//property[@name='h1']/value" />
				</a>
				<p>
					<xsl:value-of select="concat('Артикул ',$article)" />
				</p>
			</td>

			<td class="price-item">
				<xsl:value-of select="concat($formatPrice,' руб.')" />
			</td>

			<td class="good-number-form">                                 
				<xsl:value-of select="$currObj//property[@name='item_amount']/value" />

			</td>

			<td>
				<xsl:value-of select="concat($formatTotalPrice,' руб.')" />
			</td>

		</tr>
                                


	</xsl:template>

 

</xsl:stylesheet>