<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output encoding="utf-8" method="html" indent="yes" />

	<xsl:template match="status_notification">
		<xsl:variable name="order" select="document(concat('uobject://',order_id))" />
		<xsl:variable name="customer" select="document(concat('uobject://',$order//property[@name='customer_id']/value/item/@id))" />
	
				<p>
					Здравствуйте,
					<strong>
						<xsl:value-of select="concat($customer//property[@name='fname']//value,' ',$customer//property[@name='lname']//value)" />
					</strong>
					!
					<br />
					Вы оформили заказ
					<strong>
						#
						<xsl:value-of select="order_number" />
					</strong>
					, ниже приведены его детали.
				</p>
				<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Информация о заказе</h4>
				<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Номер заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="order_number" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Дата заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="document(concat('udata://system/convertDate/',$order//property[@name='order_date']/value/@unix-timestamp,'/Y-m-d%20H:i:s'))/udata" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Статус заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$order//property[@name='status_id']/value/item/@name" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>e-mail:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$customer//property[@name='e-mail']//value" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Контактный телефон:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$customer//property[@name='phone_user']//value" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Адрес доставки:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$customer//property[@name='adres_dostavki']//value" />
						</td>
					</tr>
                                        <tr>
						<td width="50%; text-align: left">
							<xsl:text>Комментарий к заказу:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$customer//property[@name='order_comment']//value" />
						</td>
					</tr>


				</table>
				<br />
				<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Содержание заказа</h4>
				<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
					<tr>
						<td style="text-align: left; font-weight: bold" width="15%">
							<xsl:text>Количество</xsl:text>
						</td>
						<td style="text-align: left; font-weight: bold" width="35%">
							<xsl:text>Название</xsl:text>
						</td>

						<td style="text-align: left; font-weight: bold" width="15%">
							<xsl:text>Цена</xsl:text>
						</td>
						<td style="text-align: left; font-weight: bold" width="20%">
							<xsl:text>Промежуточный итог</xsl:text>
						</td>
					</tr>
					<xsl:apply-templates select="$order//property[@name='order_items']/value/item" mode="order-item" />
					<tr>
						<td colspan="5" style="height: 20px	">&#160;</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
						<td style="text-align: left" colspan="3">
							Промежуточный итог:&#160;
							<xsl:value-of select="document(concat('udata://custom/formatPrice/',$order//property[@name='total_original_price']//value,'/(,)/'))/udata" />
							&#160;RUB
							
						</td>
					</tr>
				</table>
					<br />
			<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Выбраный магазин</h4>
			<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
			<tr>
				<xsl:value-of select="$order//property[@name='store']/value/page/name"/>		
			</tr>
		</table>
		
	</xsl:template>

	<xsl:template match="status_notification_receipt">
		<xsl:variable name="order" select="document(concat('uobject://',order_id))" />
		<xsl:variable name="customer" select="document(concat('uobject://',$order//property[@name='customer_id']/value/item/@id))" />
		
				<p>
					Здравствуйте,
					<strong>
						<xsl:value-of select="$customer//property[@name='fname']//value" />
					</strong>
					!
					<br />
					Вы оформили заказ
					<strong>
						#
						<xsl:value-of select="order_number" />
					</strong>
					, ниже приведены его детали.
				</p>
				<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Информация о заказе</h4>
				<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Номер заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="order_number" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Дата заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="document(concat('udata://system/convertDate/',$order//property[@name='order_date']/value/@unix-timestamp,'/Y-m-d%20H:i:s'))/udata" />
						</td>
					</tr>
					<tr>
						<td width="50%; text-align: left">
							<xsl:text>Статус заказа:</xsl:text>
						</td>
						<td width="50%">
							<xsl:value-of select="$order//property[@name='status_id']/value/item/@name" />
						</td>
					</tr>

				</table>
				<br />
				<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Содержание заказа</h4>
				<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
					<tr>
						<td style="text-align: left; font-weight: bold" width="15%">
							<xsl:text>Количество</xsl:text>
						</td>
						<td style="text-align: left; font-weight: bold" width="35%">
							<xsl:text>Название</xsl:text>
						</td>

						<td style="text-align: left; font-weight: bold" width="15%">
							<xsl:text>Цена</xsl:text>
						</td>
						<td style="text-align: left; font-weight: bold" width="20%">
							<xsl:text>Промежуточный итог</xsl:text>
						</td>
					</tr>
					<xsl:apply-templates select="$order//property[@name='order_items']/value/item" mode="order-item" />
					<tr>
						<td colspan="5" style="height: 20px	">&#160;</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
						<td style="text-align: left" colspan="3">
							Промежуточный итог:&#160;
							<xsl:value-of select="document(concat('udata://custom/formatPrice/',$order//property[@name='total_original_price']//value,'/(,)/'))/udata" />
							&#160;RUB
							
						</td>
					</tr>
				</table>
					<br />
				<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Выбраный магазин</h4>
					<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
					<tr>
						<xsl:value-of select="$order//property[@name='store']/value/page/name"/>		
					</tr>
				</table>
			
		
	</xsl:template>

	<xsl:template match="neworder_notification">
		<xsl:variable name="order" select="document(concat('uobject://',order_id))" />
		<xsl:variable name="customer" select="document(concat('uobject://',$order//property[@name='customer_id']/value/item/@id))" />
		<xsl:variable name="address" select="document(concat('uobject://',$order//property[@name='delivery_address']/value/item[1]/@id))/udata/object" />
		<xsl:variable name="address-string" select="concat($address//property[@name='index']/value,', ',$address//property[@name='region']/value,', ',$address//property[@name='city']/value,', ',$address//property[@name='street']/value,', д. ',$address//property[@name='house']/value,', кв.',$address//property[@name='flat']/value)" />


		<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Информация о заказе</h4>
		<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
			<tr>
				<td width="50%; text-align: left">
					<xsl:text>Номер заказа:</xsl:text>
				</td>
				<td width="50%">
					<xsl:value-of select="order_number" />
				</td>
			</tr>
			<tr>
				<td width="50%; text-align: left">
					<xsl:text>Дата заказа:</xsl:text>
				</td>
				<td width="50%">
					<xsl:value-of select="document(concat('udata://system/convertDate/',$order//property[@name='order_date']/value/@unix-timestamp,'/Y-m-d%20H:i:s'))/udata" />
				</td>
			</tr>
			<tr>
				<td width="50%; text-align: left">
					<xsl:text>Статус заказа:</xsl:text>
				</td>
				<td width="50%">
					<xsl:value-of select="$order//property[@name='status_id']/value/item/@name" />
				</td>
			</tr>
		
		</table>
		<br />
	
		
		<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Информация о клиенте</h4>
		<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
			<tr>
				<td width="50%; text-align: left">
					<strong>Информация о клиенте</strong>
					<table width="100%" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr>
							<td width="50%; text-align: left">
								<xsl:text>E-mail:</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$customer//property[@name='e-mail']//value" />
							</td>
						</tr>
					</table>
					<br />
					<strong>Контактная информация плательщика</strong>
					<table width="100%" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr>
							<td width="50%; text-align: left">
								<xsl:text>ФИО:</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$customer//property[@name='fname']/value" />
							</td>
						</tr>
						<tr>
							<td width="50%; text-align: left">
								<xsl:text>Страна:</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$customer//property[@name='country_user']/value" />
							</td>
						</tr>

						<tr>
							<td width="50%; text-align: left">
								<xsl:text>Город:</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$customer//property[@name='city_user']/value" />
							</td>
						</tr>


						<tr>
							<td width="50%; text-align: left">
								<xsl:text>Телефон:</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$customer//property[@name='phone_user']/value" />
							</td>
						</tr>

						<tr>
							<td width="50%; text-align: left">
								<xsl:text>Дата рождения:</xsl:text>
							</td>
							<td>
								<xsl:variable name="dateB" select="$customer//property[@name='date_birsday']/value/@unix-timestamp" />
								<xsl:value-of select="document(concat('udata://system/convertDate/',$dateB,'/(d.m.Y)'))/udata" />
							</td>
						</tr>

					</table>
				</td>

			</tr>
		</table>
		<br />
		<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Содержание заказа</h4>
		<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
			<tr>
				<td style="text-align: left; font-weight: bold" width="15%">
					<xsl:text>Количество</xsl:text>
				</td>
				<td style="text-align: left; font-weight: bold" width="35%">
					<xsl:text>Название</xsl:text>
				</td>

				<td style="text-align: left; font-weight: bold" width="15%">
					<xsl:text>Цена</xsl:text>
				</td>
				<td style="text-align: left; font-weight: bold" width="20%">
					<xsl:text>Промежуточный итог</xsl:text>
				</td>
			</tr>
			<xsl:apply-templates select="$order//property[@name='order_items']/value/item" mode="order-item" />
			<tr>
				<td colspan="5" style="height: 20px	">&#160;</td>
			</tr>
			<tr>
				<td colspan="2">&#160;</td>
				<td style="text-align: left" colspan="3">
					Промежуточный итог:&#160;
					<xsl:value-of select="document(concat('udata://custom/formatPrice/',$order//property[@name='total_original_price']//value,'/(,)/'))/udata" />
					&#160;RUB
				
				</td>
			</tr>
		</table>
			<br />
			<h4 style="background: #cdcdcd; padding-bottom: 0; margin-bottom: 0; font-size: 14px; width: 800px">Выбраный магазин</h4>
			<table cellpadding="0" cellspacing="0" border="0" style="width:800px">
			<tr>
				<xsl:value-of select="$order//property[@name='store']/value/page/name"/>		
			</tr>
		</table>
	
	</xsl:template>

	<xsl:template match="item" mode="order-item">
		<xsl:variable name="item" select="document(concat('uobject://',@id))" />
		<tr>
			<td style="text-align: left">
				<xsl:value-of select="$item//property[@name='item_amount']//value" />
			</td>
			<td style="text-align: left">
				<xsl:value-of select="@name" />
			</td>

			<td style="text-align: left">

				<xsl:value-of select="document(concat('udata://custom/formatPrice/',$item//property[@name='item_price']//value,'/(,)/'))/udata" />
				&#160;RUB
			</td>
			<td style="text-align: left">
				<xsl:value-of select="document(concat('udata://custom/formatPrice/',$item//property[@name='item_total_price']//value,'/(,)/'))/udata" />
				&#160;RUB
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>