<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Dillers list page -->
	<xsl:template match="/result[page/@type-id=151]" priority="1">
		<xsl:variable name="dillersList" select="document(concat('usel://getChildPage/',$document-page-id,'/0'))/udata" />

		<div class="ml40">
			<!-- content/menu.xsl -->

			<xsl:call-template name="header" />
			<div class="diler-map-case">
				<xsl:apply-templates select="$dillersList/page" mode="dillerMap" />

				<img src="{$template-resources}images/ru-map.png" alt="" class="" />
			</div>

			<xsl:apply-templates select="$dillersList" mode="dillerStrangeList" />
		</div>
	</xsl:template>

	<xsl:template match="page" mode="dillerMap">
		<xsl:variable name="curr" select="document(concat('upage://',@id))" />
		<xsl:variable name="top" select="$curr//property[@name='top']/value" />
		<xsl:variable name="left" select="$curr//property[@name='left']/value" />

		<a href="{@link}" class="diler-marker" style="top: {$top}px; left: {$left}px;">
			<xsl:value-of select="position()" />
		</a>
	</xsl:template>


	<xsl:template match="udata" mode="dillerStrangeList">
		<xsl:variable name="middle" select="ceiling(total div 3)" />
		<xsl:choose>
			<xsl:when test="$middle &gt; 2">
				<xsl:call-template name="threeColumns">
					<xsl:with-param name="first" select="$middle" />
					<xsl:with-param name="middle" select="round(total div 3)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="oneColumn">
					<xsl:with-param name="first" select="$middle" />
					<xsl:with-param name="middle" select="round(total div 3)" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="threeColumns">
		<xsl:param name="first" />
		<xsl:param name="middle" />
		<xsl:variable name="step1" select="$first+1" />
		<xsl:variable name="step2" select="$step1+$middle" />
		<xsl:variable name="step3" select="$step2 - 1" />


		<ul class="dilers-list ib mt40">
			<xsl:apply-templates select="page[position() &lt; $step1]" mode="dillersItem">
				<xsl:with-param name="plusMiddle">
					<xsl:text>0</xsl:text>
				</xsl:with-param>
			</xsl:apply-templates>
		</ul>
		<ul class="dilers-list ib ml100 mt40">
			<xsl:apply-templates select="page[position() &gt; $step1 - 1 and position() &lt; $step2]" mode="dillersItem">
				<xsl:with-param name="plusMiddle" select="$step1 - 1" />
			</xsl:apply-templates>
		</ul>
		<ul class="dilers-list ib ml100 mt40">
			<xsl:apply-templates select="page[position() &gt; $step3]" mode="dillersItem">
				<xsl:with-param name="plusMiddle" select="$step3" />
			</xsl:apply-templates>
		</ul>
	</xsl:template>

	<xsl:template name="oneColumn">
		<xsl:param name="middle" />
		<ul class="dilers-list ib mt40">
			<xsl:apply-templates select="page" mode="dillersItem" />
		</ul>
	</xsl:template>


	<xsl:template match="page" mode="dillersItem">
		<xsl:param name="plusMiddle" />
		<li>
			<xsl:value-of select="concat(position()+$plusMiddle,'. ')" />
			<a href="{@link}">
				<xsl:value-of select="name" />
			</a>
		</li>
	</xsl:template>
	<!--### END Dillers list page -->

</xsl:stylesheet> 