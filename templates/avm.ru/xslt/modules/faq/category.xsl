<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:udt="http://umi-cms.ru/2007/UData/templates" xmlns:umi="http://www.umi-cms.ru/TR/umi" exclude-result-prefixes="xsl date udt umi">

	<!-- <xsl:template match="result[@module = 'faq'][@method = 'category']"> <div id="faq"> <div umi:element-id="{$document-page-id}" umi:field-name="content"> <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" /> </div> <xsl:apply-templates select="document(concat('udata://faq/category//', $document-page-id))/udata" /> </div> </xsl:template> -->

	<xsl:template match="udata[@module = 'faq'][@method = 'category']">
		<xsl:param name="catId" />
		<xsl:choose>
			<xsl:when test="count(items/item) &gt; 0">
				<ul umi:element-id="{$catId}" umi:module="faq" umi:add-method="none" umi:region="list" umi:sortable="sortable">
					<xsl:apply-templates select="items/item" mode="question" />
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>В выбранной категории пока нет вопросов.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="item" mode="question">
		<li umi:element-id="{@id}" umi:region="row">
                    <span style="font-size: 12px;  margin-right: 10px;">
                        <xsl:value-of select="document(concat('upage://',@id))//property[@name='publish_time']/value/@formatted-date"/>
                    </span>
                    <span style="font-size: 12px;  margin-right: 10px;">
                        <xsl:value-of select="substring-before(document(concat('upage://',@id))//property[@name='author_id']/value/item/@name,' ')"/>
                    </span>
                    
			<a href="#" class="ib c1" umi:field-name="question" umi:empty="Вопрос">
				<xsl:value-of select="question" disable-output-escaping="yes" />
			</a>
			<p class="mt20 sc1" umi:element-id="{@id}" umi:field-name="answer" umi:empty="Ответ на вопрос">
				<xsl:value-of select="answer" disable-output-escaping="yes" />
			</p>
		</li>
	</xsl:template>
        


</xsl:stylesheet>