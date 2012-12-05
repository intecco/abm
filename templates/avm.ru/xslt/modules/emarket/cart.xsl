<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="udata[@method = 'cart']" mode="short">
		<li class="ib bucket-ico ml20">
			<xsl:if test="summary/amount &gt; 0">
				<xsl:attribute name="class">
					<xsl:text>ib bucket-ico ml20 fullcart</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<a href="/personal/cart/">
				<xsl:text>Корзина</xsl:text>
			</a>
			<xsl:choose>
				<xsl:when test="summary/amount &gt; 0">
					<p><xsl:value-of select="document(concat('udata://content/morphWords/',summary/amount,'/(product)/'))/udata" /><xsl:text> на </xsl:text><xsl:value-of select="summary/price/actual" /><xsl:text> рублей</xsl:text></p>
				</xsl:when>
				<xsl:otherwise>
					<p>Корзина пуста</p>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>

	<!--### START Cart templates -->
	<xsl:template match="result[@method = 'cart']">
		<xsl:apply-templates select="document('udata://content/redirect/(/personal/cart/)')" />
	</xsl:template>

	<xsl:template match="udata[@method = 'cart']">
		<table class="simple-table">
			<tr>
				<th>Товар</th>
				<th>Цена</th>
				<th>Кол-во</th>
				<th>Стоимость</th>
				<th></th>
			</tr>
			<tr>
				<td colspan="5" style="text-align:center">
					<xsl:text>&basket-empty;</xsl:text>
				</td>
			</tr>
		</table>
	</xsl:template>


	<xsl:template match="udata[@method = 'cart'][count(items/item) &gt; 0]">

		<xsl:variable name="storeList" select="document('udata://content/getStoreList/')/udata" />

		<table class="simple-table">
			<tr>
				<th>Товар</th>
				<th>Цена</th>
				<th>Кол-во</th>
				<th>Стоимость</th>
				<th></th>
			</tr>

			<xsl:apply-templates select="items/item" mode="cartItems" />
			<xsl:apply-templates select="summary" />


		</table>
		<xsl:if test="$storeList/total &gt; 0">
			<form action="/emarket/customPurchasing/" method="post" id="purshForm">
				<h3>Выберите способ доставки</h3>
				<div class="edit-personal-data" style="background: none !important">
					<select name="delivery_id" id="delivery_id" class="mt10">
						<xsl:apply-templates select="document('udata://emarket/deliveryList')/udata//item" mode="delivery_list" />
					</select>
				</div>
				<div id="payment_self" class="mt20">
					<div class="smalltext">
						<p>Выберите магазин в который вы собираетесь приехать:</p>
					</div>
					
					<xsl:apply-templates select="$storeList/city" mode="storeListItem" />
				</div>
				<div id="payment_delivery" style="display: none; background: none !important" class="edit-personal-data">
					<div class="mt20 smalltext">
						<xsl:value-of select="document('uobject://1199.opisanie')//value" disable-output-escaping="yes" />
					</div>
					<div class="mt20 fullinput">
						<p>Ваше имя:</p>
						<input type="text" name="data[{$user-id}][fname]" value="{$user-info//property[@name='fname']/value}" class="required" />
					</div>
                                        
                                        <div class="mt20 fullinput">
						<p>Регион:</p>
						<input type="text" name="data[{$user-id}][region]" value="{$user-info//property[@name='region']/value}" class="required" />
					</div>
                                        
                                        <div class="mt20 fullinput">
						<p>Город:</p>
						<input type="text" name="data[{$user-id}][gorod]" value="{$user-info//property[@name='gorod']/value}" class="required" />
					</div>
                                        <div class="mt20 fullinput">
						<p>Улица:</p>
						<input type="text" name="data[{$user-id}][street]" value="{$user-info//property[@name='street']/value}" class="required" />
					</div>
					
                                        <div class="mt20 halfinput ib">
						<p>Дом:</p>
						<input type="text" name="data[{$user-id}][dom]" value="{$user-info//property[@name='dom']/value}" class="required" />
					</div>
                                        <div class="mt20 halfinput ib ml40">
						<p>Квартира:</p>
						<input type="text" name="data[{$user-id}][kvartira]" value="{$user-info//property[@name='kvartira']/value}" class="required" />
					</div>
                                        
					<div class="mt20 halfinput ib">
						<p>E-mail:</p>
						<input type="text" name="data[{$user-id}][e-mail]" value="{$user-info//property[@name='e-mail']/value}" class="required email" />
					</div>
					
					<div class="mt20 halfinput ib ml40">
						<p>Телефон:</p>
						<input type="text" name="data[{$user-id}][phone_user]" value="{$user-info//property[@name='phone_user']/value}" class="required" />
					</div>
					
<!--					<div class="mt20 halfinput ib">
						<p>Адрес доставки:</p>
						<textarea name="data[{$user-id}][adres_dostavki]" value="{$user-info//property[@name='adres_dostavki']/value}" cols="" rows="" class="required"></textarea>
					</div>-->
					
					<div class="mt20 halfinput ib">
						<p>Время доставки:</p>
						<select name="data[{$user-id}][time_order]" value="{$user-info//property[@name='order_time']/value}">
							<xsl:apply-templates select="document('usel://getOrderTime')/udata//item" mode="order_time" class="required" />
						</select>
					</div>
					
					<div class="mt20 fullinput">
						<p>Комментарий к заказу:</p>
						<textarea name="order_comment" value="{$order-info//property[@name='order_comment']/value}" cols="" rows="" class="required"></textarea>
					</div>
					
				</div>
			</form>
		</xsl:if>
		<a href="{$lang-prefix}/emarket/purchase/" class="btn large-btn ib mt30 linkSubmit" rel="purshForm">Оформить заказ</a>
	</xsl:template>
	
	<xsl:template match="item" mode="order_time">
		<option value="{@id}"><xsl:value-of select="@name" /></option>
	</xsl:template>
	
	<xsl:template match="item" mode="delivery_list">
		<option value="{@id}"><xsl:value-of select="@name" /></option>
	</xsl:template>

	<xsl:template match="item" mode="cartItems">

		<xsl:variable name="curr" select="document(concat('upage://',page/@id))/udata/page" />
		<xsl:variable name="article" select="$curr//property[@name='article']/value" />

		<xsl:variable name="price" select="price/actual" />
		<xsl:variable name="total-price" select="total-price/actual" />

		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
		<xsl:variable name="formatTotalPrice" select="document(concat('udata://custom/formatNumber/',$total-price))/udata" />
		<tr class="cart_item_{@id}">
			<td class="good-item name">
				<a href="{page/@link}">
					<xsl:call-template name="preResize">
						<xsl:with-param name="element-id" select="page/@id" />
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
				<a href="{page/@link}">
					<xsl:value-of select="@name" />
				</a>
				<p>
					<xsl:value-of select="concat('Артикул ',$article)" />
				</p>
			</td>

			<td class="price-item">
				<xsl:value-of select="concat($formatPrice,' руб.')" />
			</td>

			<td class="good-number-form">
				<input type="text" value="{amount}" onkeyup="
					var e = jQuery(this).next('input'), old = e.val();
					e.val(this.value);
					site.basket.modify({@id}, this.value, old);
				" />
				<input type="hidden" value="{amount}" />
			</td>

			<td class="price-item cart_item_price_{@id}">
				<xsl:value-of select="concat($formatTotalPrice,' руб.')" />
			</td>

			<td>
				<a href="{$lang-prefix}/emarket/basket/remove/item/{@id}/" id="{@id}" class="del delete-bucket-item">Удалить</a>
			</td>
		</tr>



	</xsl:template>

	<xsl:template match="udata[@method = 'cart']/summary">
		<xsl:variable name="price" select="price/actual" />
		<xsl:variable name="formatPrice" select="document(concat('udata://custom/formatNumber/',$price))/udata" />
		<tr>
			<td colspan="5" class="lc">
				<p class="total mt10 mb10 cart_summary">
					<xsl:value-of select="concat('Итого ',$formatPrice,' руб.')" />
				</p>
			</td>
		</tr>
	</xsl:template>


	<xsl:template match="city" mode="storeListItem">
		<xsl:variable name="curr" select="document(concat('upage://',@cat_id))/udata/page" />
		<div class="select-city ib">
			<h4 class="mt20">
				<xsl:value-of select="$curr//property[@name='h1']/value" />
			</h4>

			<ul class="mt20">
				<xsl:apply-templates select="item" mode="storeList">
					<xsl:with-param name="parent_pos" select="position()" />
				</xsl:apply-templates>
			</ul>

		</div>
	</xsl:template>

	<xsl:template match="item" mode="storeList">
		<xsl:param name="parent_pos" />
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata/page" />
		<li>
			<xsl:if test="position() = last()">
				<xsl:attribute name="class"><xsl:text>lc</xsl:text></xsl:attribute>
			</xsl:if>
			<label>
				<input type="radio" class="ib" name="store_id" value="{@id}">
					<xsl:if test="$parent_pos = 1 and position()=1">
						<xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute>
					</xsl:if>
				</input>
				&#160;
				<div class="ib">
<!--					<p>
						<b>
							<xsl:value-of select="$curr//property[@name='h1']/value" />
						</b>
					</p>-->
					<xsl:value-of select="$curr//property[@name='centralnyj_ofis_i_magazin']/value" disable-output-escaping="yes" />
                                        <xsl:value-of select="$curr//property[@name='telfaks']/value" disable-output-escaping="yes" />
					<a href="/contacts/#map_{@id}" target="__blank">Посмотреть на карте</a>
				</div>
			</label>
		</li>
	</xsl:template>
	<!--### END Cart templates -->



	<!--### START Templates for old orders -->
	<xsl:template match="properties" mode="cartItemsOld">
		<xsl:apply-templates select=".//group/property[@name='order_items']/value/item" mode="cartItemsOld" />
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
	<xsl:template match="item" mode="cartItemsOld">

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
				<input type="text" value="{$currObj//property[@name='item_amount']/value}" disabled="disabled" />

			</td>

			<td>
				<xsl:value-of select="concat($formatTotalPrice,' руб.')" />
			</td>

		</tr>

	</xsl:template>
	<!--### END Templates for old orders -->

</xsl:stylesheet>