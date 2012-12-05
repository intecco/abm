<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink" xmlns:fb="http://www.facebook.com/2008/fbml" exclude-result-prefixes="xsl umi xlink fb">

	<!--### START comments block in user page -->
	<xsl:template match="udata[@module = 'comments' and @method = 'insert']" mode="commentsListPage">
		<xsl:choose>
			<xsl:when test="count(items/item) &gt; 0">
				<xsl:apply-templates select="items/item" mode="commentsListPage" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Сообщений нет.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="item" mode="commentsListPage">
		<xsl:variable name="authorId" select="@author_id" />
		<xsl:variable name="currUserId" select="document(concat('uobject://',$authorId,'.user_id'))/udata/property/value/item/@id" />

		<div class="item cf">
			<div class="rgt">
				<xsl:if test="$user-id = $currUserId">
					<xsl:attribute name="class">lft</xsl:attribute>
				</xsl:if>
				<span>
					<xsl:value-of select="." />
				</span>
			</div>
		</div>
	</xsl:template>
	<!-- END comments block in user page -->


	<!--### START comments page = chat -->
	<xsl:template match="result[@method='content' and parents/page[position()=1]/@id =1801 ]">
		<xsl:if test="$user-type!='sv'">
			<xsl:apply-templates select="document('udata://content/redirect/(/emarket/personal/)')" />
		</xsl:if>
		<div class="lk cf">
			<div class="lkContent cf" style="width: 100%;">
				<div class="chat commentsPage">
					<div class="window">

						<xsl:apply-templates select="document(concat('udata://comments/insert/',$document-page-id))" mode="commentsPage" />
					</div>
					<form action="/comments/post/{$document-page-id}/">
						<div class="field">
							<input type="text" class="input" name="comment" />
						</div>
						<div class="field">
							<input type="submit" class="y-button" value="Отправить" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'comments' and @method = 'insert']" mode="commentsPage">
		<xsl:apply-templates select="items/item" mode="commentsListPage" />
	</xsl:template>
	<!-- END comments page = chat -->

</xsl:stylesheet>