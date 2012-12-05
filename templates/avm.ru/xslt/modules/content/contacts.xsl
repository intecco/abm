<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Cantact page -->
	<xsl:template match="/result[page/@type-id=111]" priority="1">


		<div class="ml40">
			<h2 class="mt30 mb20">
				<xsl:value-of select=".//property[@name='h1']/value" />
			</h2>
			<xsl:apply-templates select="document(concat('usel://getChildPage/',$document-page-id,'/0'))/udata" mode="contactsItems" />
		</div>
	</xsl:template>


	<xsl:template match="udata" mode="contactsItems">
		<xsl:if test="total &gt; 0">
			<xsl:apply-templates select="page" mode="contactsItem" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="page" mode="contactsItem">
		<xsl:variable name="childs" select="document(concat('usel://getChildPage/',@id,'/0'))/udata" />
		<xsl:if test="$childs/total &gt; 0">
			<section class="contacts-section">
				<h2>
					<xsl:value-of select="name" />
				</h2>
				<xsl:apply-templates select="$childs" mode="reprItems" />

			</section>
		</xsl:if>
	</xsl:template>

	<xsl:template match="udata" mode="reprItems">
		<ul class="contacts-list">
			<xsl:apply-templates select="page" mode="reprItems" />

		</ul>
	</xsl:template>

	<xsl:template match="page" mode="reprItems">
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata/page" />
		<li umi:element-id="{@id}">
			<xsl:if test="position()=last()">
				<xsl:attribute name="class">lc</xsl:attribute>
			</xsl:if>

			<div class="ib">
				<xsl:apply-templates select="$curr//group[@name='svojstva']/property" mode="propertyRepr" />
				<xsl:apply-templates select="$curr//group[@name='shop_photos']" mode="morePhotos">
					<xsl:with-param name="page-id" select="@id" />
				</xsl:apply-templates>

			</div>

			<div class="ib fr mt20">
				<xsl:apply-templates select="$curr//group[@name='google_map']" mode="googleMap">
					<xsl:with-param name="page-id" select="@id" />
				</xsl:apply-templates>


				<div class="mt30">
					<xsl:apply-templates select="$curr//group[@name='svojstva_pravyj_blok']/property" mode="propertyRepr" />
				</div>
			</div>
			<div style="clear: both"></div>
		</li>
	</xsl:template>

	<xsl:template match="property" mode="propertyRepr">
		<xsl:variable name="chkType" select="document(concat('udata://custom/getPropertyHelper/',@id))/udata/type" />
		<xsl:choose>
			<xsl:when test="$chkType = 'h4'">
				<!--<h4 class="mt20">
					<xsl:value-of select="title" />
				</h4>-->
			</xsl:when>
			<xsl:otherwise>
				<p class="mt10">
					<b>
						<xsl:value-of select="title" />
					</b>
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<div umi:field-name="{@name}">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>

	<!-- more photos -->
	<xsl:template match="group" mode="morePhotos">
		<xsl:param name="page-id" />
		<xsl:if test="count(property) &gt; 0">
			<p class="mt10 fancy-title">
				<b>
					<xsl:value-of select="title" />
				</b>
			</p>
			<div class="more_photos_container" rel="fancy_{$page-id}">
				<xsl:apply-templates select="property" mode="propertyPhoto">
					<xsl:with-param name="page-id" select="$page-id" />
				</xsl:apply-templates>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="property" mode="propertyPhoto">
		<xsl:param name="page-id" />
		<a href="{value}" class="ib mt10" rel="fancy_{$page-id}">
			<xsl:if test="position() &gt; 1 and (position()-1) mod 3 &gt; 0">
				<xsl:attribute name="class">ib ml10 mt10</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="catalog-thumbnail">
				<xsl:with-param name="element-id" select="$page-id" />
				<xsl:with-param name="field-name" select="@name" />
				<xsl:with-param name="width">
					<xsl:text>93</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="height">
					<xsl:text>62</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="class">
					<xsl:text>shop-photo</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
		</a>
	</xsl:template>

	<!-- google map -->
	<xsl:template match="group" mode="googleMap">
		<xsl:param name="page-id" />
		<xsl:variable name="latitude" select="property[@name='latitude']/value" />
		<xsl:variable name="longitude" select="property[@name='longitude']/value" />
		<xsl:variable name="google_title" select="property[@name='google_title']/value" />
		<xsl:variable name="desc" select="property[@name='desc']/value" />

		<xsl:if test="$latitude!='' and $longitude!=''">
			<div class="google-map" id="map_{$page-id}" rel="{$page-id}"></div>
			<input type="hidden" id="latitude_{$page-id}" value="{$latitude}" />
			<input type="hidden" id="longitude_{$page-id}" value="{$longitude}" />
			<input type="hidden" id="google_title_{$page-id}" value="{$google_title}" />
			<input type="hidden" id="desc_{$page-id}" value="{$desc}" />
		</xsl:if>
	</xsl:template>
	<!--### END Cantact page -->

</xsl:stylesheet> 