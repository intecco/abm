<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--### START Order list page -->
	<xsl:template match="/result[@method = 'ordersList']">
		<xsl:apply-templates select="document('udata://content/redirect/(/personal/orders/)')" />
	</xsl:template>



	<xsl:template match="udata[@method = 'ordersList']">

		<table class="simple-table">
			<tr>
				<th>
					<xsl:text>&order-number;</xsl:text>
				</th>
				<th>Дата</th>
				<th>
					<xsl:text>&order-status;</xsl:text>
				</th>
			</tr>
			<xsl:choose>
				<xsl:when test="count(items/item)">
					<xsl:apply-templates select="items/item" mode="order" />
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td colspan='3'>
							<xsl:text>Вы еще не оформили ни одного заказа</xsl:text>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</table>

	</xsl:template>

	<xsl:template match="item" mode="order">
		<xsl:apply-templates select="document(concat('udata://emarket/order/', @id))/udata" />
</xsl:template>

	<xsl:template match="item[position() = last()]" mode="order">
		<xsl:apply-templates select="document(concat('udata://emarket/order/', @id))/udata" />
	</xsl:template>


	<xsl:template match="udata[@module = 'emarket'][@method = 'order']">
		<xsl:variable name="time" select="document(concat('uobject://', @id, '.order_date'))//property/value/@unix-timestamp" />
		<xsl:variable name="convTime" select="document(concat('udata://system/convertDate/',$time,'/(d.m.Y)'))/udata" />

		<tr>
			<td>
				<a href="?show_order={@id}">
					<xsl:value-of select="number" />
				</a>
			</td>
			<td>
				<xsl:apply-templates select="$convTime" />
			</td>
			<td>
				<xsl:value-of select="status/@name" />
			</td>
		</tr>

	</xsl:template>
	<!--### START Order list page -->



	<!--### START Detail order page -->
	<xsl:template name="detailOrder">
		<xsl:variable name="order" select="document(concat('uobject://',$show_order))/udata/object/properties" />
		<xsl:variable name="catalogPage" select="document('udata://custom/getPageId/110')/udata/page"/>
		<xsl:variable name="customer_id" select="$order//property[@name='customer_id']/value/item/@id" />
		
			<xsl:if test="$user-id!=$customer_id">
					<xsl:apply-templates select="document('udata://content/redirect/(/)')/udata" />
				</xsl:if>
				
		<div class="order-single order-single-html">
			<table class="simple-table ib">

				<tr>
					<th>Товар</th>
					<th>Цена</th>
					<th>Кол-во</th>
					<th>Стоимость2</th>

				</tr>
				<xsl:choose>
					<xsl:when test="count($order/group/property[@name='order_items']/value/item) &gt; 0">
						<xsl:apply-templates select="$order" mode="cartItemsOld" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="document(concat('udata://content/redirect/(',$curr-result/page/@link,')'))/udata" />
					</xsl:otherwise>
				</xsl:choose>

			</table>

			<div class="order-widget ib ml10">
				<a href="/print_order/?order_id={$show_order}" class="btn large-btn ib">Распечатать заказ</a>
				<a href="{$catalogPage/@link}" class="db mt20">Продолжить покупки</a>
				<a href="{$curr-result/page/@link}" class="db mt20">Список заказов</a>
			</div>



			<div class="shop-placement">
				<xsl:apply-templates select="$order//property[@name='store']" mode="storeBlock" />
				<a href="/print_order/?order_id={$show_order}" class="btn large-btn ib mt30">Распечатать заказ</a>

			</div>
		</div>
	</xsl:template>

	<xsl:template match="property" mode="storeBlock">
		<xsl:variable name="curr" select="document(concat('upage://',value/page/@id))/udata/page" />
		<xsl:variable name="parent" select="document(concat('upage://',$curr/@parentId))/udata/page" />

		<h3 class="mt10">К выдаче в магазине</h3>
		<h4 class="mt20">
			<xsl:value-of select="$parent/name" />
		</h4>

		<xsl:apply-templates select="$curr//group[@name='svojstva']/property" mode="storeProperty" />

		<div class="map ib mt30">
			<xsl:apply-templates select="$curr//group[@name='google_map']" mode="googleMap">
				<xsl:with-param name="page-id" select="@id" />
			</xsl:apply-templates>
		</div>

		<div class="ib mt30 ml20">
			<xsl:apply-templates select="$curr//group[@name='svojstva_pravyj_blok']/property" mode="rightbBlockStore" />
		</div>
	</xsl:template>

	<xsl:template match="property" mode="storeProperty">
		<xsl:choose>
			<xsl:when test="@name='centralnyj_ofis_i_magazin'">
				<h4 class="mt20">
					<xsl:value-of select="title" />
				</h4>
			</xsl:when>
			<xsl:otherwise>
				<p class="mt10">
					<b>
						<xsl:value-of select="title" />
						<xsl:text>:</xsl:text>
					</b>
				</p>
			</xsl:otherwise>
		</xsl:choose>


		<div class="mt5 {@name}">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>


	<xsl:template match="property" mode="rightbBlockStore">
		<p>
			<xsl:if test="position() = 1">
				<xsl:attribute name="class"><xsl:text>mt10</xsl:text></xsl:attribute>
			</xsl:if>
			<b>
				<xsl:value-of select="title" />
				<xsl:text>:</xsl:text>
			</b>
		</p>
		<div class="mt5 {@name}">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>

	</xsl:template>
	<!--### END Detail order page -->


</xsl:stylesheet>