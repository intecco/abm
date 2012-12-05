<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="result[@method = 'forget']">
		<xsl:apply-templates select="document('udata://content/redirect/(/forget/)')" />
	</xsl:template>

	<xsl:template match="/result[@module='content' and (page/@alt-name='forget' or page/@id='72')]">
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />

			<form method="post" action="/users/forget_do/" rel="must_checked" onsubmit="site.forms.data.save(this);" id="forgForm">
				<table class="registration-form">

					<xsl:if test="count($errors/items/item) &gt; 0">

						<xsl:apply-templates select="$errors" />

					</xsl:if>

					<tr>
						<td>
							<xsl:text>Введите ваш E-mail</xsl:text>
							<span class="req">
								<xsl:text> *</xsl:text>
							</span>
						</td>
						<td>
							<input type="text" name="forget_email" rel="email" class="required" />
						</td>
					</tr>

					<tr>
						<td colspan="2" class="lc">
							<a href="/login">Войти</a>
							<a href="/registrate" class="ml10">Регистрация</a>
							<br />
							<p class="mt10">
								<span class="req">*</span>
								<xsl:text> Обязательные поля</xsl:text>
							</p>
							<a href="#" class="btn large-btn ib mt20 linkSubmit" rel="forgForm">Отправить</a>
						</td>
					</tr>

				</table>
			</form>
		</div>
	</xsl:template>



	<xsl:template match="result[@method = 'forget_do']">
		<xsl:apply-templates select="document('udata://content/redirect/(/forget/password_send/)')" />
	</xsl:template>


	<xsl:template match="/result[@module='content' and (page/@alt-name='password_send' or page/@id='73')]">
		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />

			<div class="content-block" umi:element-id="{$document-page-id}" umi:field-name="content">
				<xsl:value-of select=".//property[@name='content']/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>


</xsl:stylesheet>