<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">
	<xsl:template match="/result[@method = 'search_do']">
		<xsl:apply-templates select="document('udata://search/search_do')" />
	</xsl:template>

	<xsl:template match="udata[@method = 'search_do']">

		<div class="content ib">

			<ul class="breadcrumbs fr">
				<li class="ib">
					<a href="/">Главная</a>
				</li>
				<li class="ib">
					<p>/</p>
				</li>
				<li class="ib lc">
					<p>Поиск</p>
				</li>
			</ul>

			<div class="ml40">
				<form class="search" action="/search/search_do/" method="get" id="seachFormIdPage">
					<input type="hidden" name="search_types" value="49" />
					<input type="text" value="{$search_string}" name="search_string" class="ib" />
					<a href="#" class="btn search-btn ib linkSubmit" rel="seachFormIdPage">Найти</a>
				</form>

				<h2 class="mt30 mb20">Результаты поиска</h2>

				<ul class="content-list">
					<xsl:choose>
						<xsl:when test="total &gt; 0">
							<xsl:apply-templates select="items/item" mode="search-result" />
						</xsl:when>
						<xsl:otherwise>
							<li>
								<strong>
									<xsl:text>&search-founded-left; "</xsl:text>
									<xsl:value-of select="$search_string" />
									<xsl:text>" &search-founded-nothing;.</xsl:text>
								</strong>
							</li>
						</xsl:otherwise>
					</xsl:choose>

				</ul>

				<xsl:apply-templates select="total" />

			</div>

		</div>


	</xsl:template>


	<xsl:template match="item" mode="search-result">
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata/page" />
		<li class="search-li">
			<a href="{@link}" umi:element-id="{@id}" umi:field-name="name">
				<xsl:value-of select="@name" />
			</a>

			<xsl:choose>
				<xsl:when test="$curr//property[@name='description']/value!=''">
					<xsl:value-of select="$curr//property[@name='description']/value" disable-output-escaping="yes" />
				</xsl:when>
				<xsl:otherwise>
					<p class="mt10">
						<xsl:value-of select="." disable-output-escaping="yes" />
					</p>
				</xsl:otherwise>
			</xsl:choose>

		</li>
	</xsl:template>

</xsl:stylesheet>