<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="total" />
	<xsl:template match="total[. &gt; ../per_page]">
		<xsl:apply-templates select="document(concat('udata://system/numpages/', ., '/', ../per_page))" />
	</xsl:template>

	<xsl:template match="udata[@method = 'numpages'][count(items)]" />
	<xsl:template match="udata[@method = 'numpages']">

		<div class="paginator">
			<xsl:if test="toprev_link">
				<xsl:apply-templates select="toprev_link" />
			</xsl:if>
<ul class="ib">
				<xsl:apply-templates select="items/item" mode="numpages" />
			</ul>
			<xsl:if test="tonext_link">
				<xsl:apply-templates select="tonext_link" />
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="item" mode="numpages">
		<li class="ib">
			<a href="{@link}">
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="item[@is-active = '1']" mode="numpages">
		<li class="ib">
			<a class="active">
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="toprev_link">
		<a href="{.}" class="prev ib mr10">Предыдущая</a>
	</xsl:template>

	<xsl:template match="tonext_link">
		<a href="{.}" class="next ib ml10">Следующая</a>
	</xsl:template>



</xsl:stylesheet>