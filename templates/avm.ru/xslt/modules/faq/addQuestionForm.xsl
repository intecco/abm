<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:udt="http://umi-cms.ru/2007/UData/templates" exclude-result-prefixes="xsl date udt">

	<xsl:template match="udata[@module = 'faq'][@method = 'addQuestionForm']">
		<xsl:variable name="categoryList" select="document(concat('udata://faq/project//', $document-page-id))/udata" />

		<form method="post" action="{action}" class="ib askquestion" id="addFaqQuestion" rel="must_checked">
			<div class="error_block">
				<xsl:apply-templates select="$errors" />
			</div>
			<input type="hidden" name="title" id="topic" />
			<h3>Задать вопрос</h3>
			<p class="mt10 mb5">Ваше имя</p>
			<input type="text" name="nick" class="required" rel="text">
				<xsl:if test="$user-type!='guest'">
					<xsl:attribute name="value"><xsl:value-of select="$user-info//property[@name='login']/value" /></xsl:attribute>
				</xsl:if>
			</input>
			<p class="mt10 mb5">Ваш e-mail</p>
			<input type="text" name="email" class="required" rel="email">
				<xsl:if test="$user-type!='guest'">
					<xsl:attribute name="value"><xsl:value-of select="$user-info//property[@name='e-mail']/value" /></xsl:attribute>
				</xsl:if>
			</input>
			<p class="mt10 mb10">Тема</p>
			<select class="changeselect" name="addQestion">
				<xsl:apply-templates select="$categoryList/lines/item" mode="optionCategory" />
			</select>
			<p class="mt10 mb5">Вопрос</p>
			<textarea name="question" id="question" class="required" rel="textArea"></textarea>
			<xsl:apply-templates select="document('udata://system/captcha/')/udata" />

			<a style="cursor:pointer" id="submitQest" class="btn large-btn ib mt20">Отправить</a>
		</form>


	</xsl:template>

</xsl:stylesheet>