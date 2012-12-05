<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">

	<!--### START Registrate -->
	<xsl:template match="result[@method = 'content' and (page/@alt-name='registration' or page/@id='69')]">
		<xsl:if test="$user-type!='guest'">
			<xsl:apply-templates select="document('udata://content/redirect/(/personal/data/)')" />
		</xsl:if>

		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			<xsl:apply-templates select="document('udata://users/registrate')" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@method = 'registrate']">
		<form enctype="multipart/form-data" method="post" action="{$lang-prefix}/users/registrate_do/" onsubmit="site.forms.data.save(this);" rel="must_checked" id="regForm">
			<table class="registration-form">
				<input type="hidden" name="login" id="user_login" />

				<xsl:if test="count($errors/items/item) &gt; 0">

					<xsl:apply-templates select="$errors" />

				</xsl:if>

				<xsl:apply-templates select="document(concat('udata://data/getCreateForm/',type_id,'/notemplate/(short_info)'))" mode="editForm">
					<xsl:with-param name="with-req">
						<xsl:text>1</xsl:text>
					</xsl:with-param>
				</xsl:apply-templates>



				<tr>
					<td>
						<xsl:text>E-mail</xsl:text>
						<span class="req">
							<xsl:text> *</xsl:text>
						</span>
					</td>
					<td>
						<input type="text" name="email" class="required email" onChange="$('#user_login').val($(this).val())" rel="email" id="mail" />
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Пароль</xsl:text>
						<span class="req">
							<xsl:text> *</xsl:text>
						</span>
					</td>
					<td>
						<input type="password" name="password" class="required" id="password" rel="pass" />
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Повторите пароль</xsl:text>
						<span class="req">
							<xsl:text> *</xsl:text>
						</span>
					</td>
					<td>
						<input type="password" name="password_confirm" class="required" rel="pass_confirm" href="password" />
					</td>
				</tr>

				<xsl:apply-templates select="document('udata://system/captcha')" mode="reg" />

				<tr>
					<td colspan="2" class="lc">
						<label>
							<input type="checkbox" name="autoSubscribe" />
							<xsl:text> Я хочу получать E-mail уведомления о спецпредложениях</xsl:text>
						</label>
						<p class="mt10">
							<span class="req">*</span>
							<xsl:text> Обязательные поля</xsl:text>
						</p>
						<a href="#" class="btn large-btn ib mt20 linkSubmit" rel="regForm">Зарегистрироваться</a>
					</td>
				</tr>

			</table>
		</form>
	</xsl:template>


	<xsl:template match="field" mode="registrate_form">
		<div class="fields">
			<div class="label">
				<xsl:value-of select="@title" />
			</div>
			<div class="form">
				<input type="text" name="{@input_name}" value="{.}" class="itext" />
			</div>
		</div>
	</xsl:template>
	<!-- END Registarte -->

	<xsl:template match="result[@method = 'registrate_done']">
		<xsl:apply-templates select="document('udata://content/redirect/(/registration/registration_accept/)')" />
	</xsl:template>


	<xsl:template match="result[@method = 'activate']">
		<xsl:variable name="activation-errors" select="document('udata://users/activate')/udata/error" />
		<article>
			<div class="in">
				<xsl:choose>
					<xsl:when test="count($activation-errors)">
						<xsl:apply-templates select="$activation-errors" />
					</xsl:when>
					<xsl:otherwise>
						<p>
							<xsl:text>&account-activated;</xsl:text>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</article>
	</xsl:template>



</xsl:stylesheet>