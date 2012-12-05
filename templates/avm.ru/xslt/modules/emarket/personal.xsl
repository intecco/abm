<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--### START Common personal page -->
	<xsl:template match="/result[@method='content' and page/@type-id='150']" priority='1'>
		<xsl:if test="$user-type='guest'">
			<xsl:apply-templates select="document('udata://content/redirect/(/login)')" />
		</xsl:if>

		<xsl:apply-templates select="document('udata://content/redirect/(/personal/data/)')" />

	</xsl:template>


	<xsl:template match="/result[@method='content' and parents/page[@type-id = '150']]" priority='1'>

		<xsl:if test="$user-type='guest'">
			<xsl:apply-templates select="document('udata://content/redirect/(/login)')" />
		</xsl:if>

		<div class="ml40">
			<h2 class="mt30 mb20">Личный кабинет</h2>

			<!-- content/menu.xsl -->
			<xsl:call-template name="subContentMenu" />

			<xsl:apply-templates select="." mode="personalSection" />
		</div>
	</xsl:template>
	<!--### END Common personal page -->


	<!--### START Personal data -->
	<xsl:template match="/result[page/@alt-name='data' or page/@id = 66]" mode="personalSection">
		<xsl:choose>
			<xsl:when test="$data_edit">
				<xsl:apply-templates select="$user-info" mode="editPersonalData" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="$user-info" mode="justShowData" />
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>
	<!--### END Personal data -->



	<!--### START Order list -->
	<xsl:template match="/result[page/@alt-name='orders' or page/@id = 67]" mode="personalSection">
	
		<xsl:choose>
			<xsl:when test="$show_order">
				<xsl:call-template name="detailOrder"  />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="document('udata://emarket/ordersList')" />
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>
	<!--### END Order list -->




	<!--### START Cart -->
	<xsl:template match="/result[page/@alt-name='cart' or page/@id = 68]" mode="personalSection">

		<div class="bucket">
			<xsl:apply-templates select="document('udata://emarket/cart')/udata" />
		</div>

	</xsl:template>
	<!--### END Cart -->


</xsl:stylesheet>