<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:udt="http://umi-cms.ru/2007/UData/templates" xmlns:umi="http://www.umi-cms.ru/TR/umi" exclude-result-prefixes="xsl date udt umi">

	<xsl:template match="result[@module = 'faq'][@method = 'project']">
		<xsl:variable name="categoryList" select="document(concat('udata://faq/project//', $document-page-id))/udata" />
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />

			<section class="qa-section">
				<form class="simple-filter">
					<p class="ib theme">
						<label class="ib mr20">Тема</label>
						<select class="changeselect" name="catagorySelect">
							<xsl:apply-templates select="$categoryList/lines/item" mode="optionCategory" />
						</select>
					</p>
				</form>
				
				<div id="faqAjaxContainer" class="ask ib mt30">
					<xsl:apply-templates select="document(concat('udata://faq/category/notemplate/',$categoryList/lines/item[position()=1]/@id))/udata">
						<xsl:with-param name="catId" select="$categoryList/lines/item[position()=1]/@id" />
					</xsl:apply-templates>
				</div>
				
				<xsl:apply-templates select="document(concat('udata://faq/addQuestionForm//', $categoryList/lines/item[position()=1]/@id))/udata" />
				
				
			</section>
		</div>



	</xsl:template>

	<xsl:template match="udata[@module = 'faq'][@method = 'project']">
		<div id="faq">
			<xsl:apply-templates select="lines/item" mode="faq_project" />
		</div>
		<xsl:apply-templates select="total" />
	</xsl:template>

	<xsl:template match="item" mode="faq_project">
		<div>
			<a href="{@link}" umi:element-id="{@id}" umi:field-name="name">
				<xsl:value-of select="@name" />
			</a>
			<div umi:element-id="{@id}" umi:field-name="content">
				<xsl:value-of select="document(concat('upage://',@id,'.content'))/udata/property/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>


	<xsl:template match="item" mode="optionCategory">
		<option value="{@id}">
			<xsl:value-of select="@name" />
		</option>
	</xsl:template>

</xsl:stylesheet>