<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="user" mode="topLink">

		<xsl:choose>
			<xsl:when test="@type='guest'">
				<li class="ib kabinet-ico ml20">
					<a href="/personal" id="loginOverlay" rel="#login-form">
						<xsl:text>Личный кабинет</xsl:text>
					</a>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li class="ib kabinet-ico ml20 when-login">
					<a href="/personal">Личный кабинет</a>
					<div class="personal-link-top">
						<p class="ib">
							<xsl:apply-templates select="$user-info//property[@name = 'lname']" />
							<xsl:apply-templates select="$user-info//property[@name = 'fname']" />
							<xsl:apply-templates select="$user-info//property[@name = 'father_name']" />
						</p>
						<a href="{$lang-prefix}/users/logout/" class="ib ml10 logout fr">Выйти</a>
					</div>
				</li>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="property[@name = 'fname' or @name = 'lname' or @name = 'father_name']">
		<xsl:value-of select="value" />
		<xsl:text> </xsl:text>
	</xsl:template>


	<xsl:template match="result[@module = 'users'][@method = 'login_do']">
		<xsl:apply-templates select="document('udata://content/redirect/(/login)/')" />
	</xsl:template>

	<xsl:template match="/result[@module='content' and(page/@alt-name='login' or page/@id = '70')]">

		<xsl:if test="$user-type!='guest'">
			<xsl:apply-templates select="document('udata://content/redirect/(/pesonal/data/)')" />
		</xsl:if>

		<div class="ml40">
			<!-- content/menu.xsl -->
			<xsl:call-template name="header" />
			<xsl:apply-templates select="document('udata://users/auth')/udata" mode="auth" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'users'][@method = 'auth']" mode="auth">

		<form method="post" action="/users/login_do/" rel="must_checked" onsubmit="site.forms.data.save(this);" id="authForm">
			<table class="registration-form">
				<input type="hidden" name="from_page" value="/pesonal/data" />

				<xsl:if test="$error_auth">
					<tr>
						<td colspan="2">
							<xsl:text>Вы ввели неверный E-mail или пароль. Проверьте раскладку клавиатуры, не нажата ли клавиша «Caps Lock» и попробуйте ввести E-mail и пароль ещё раз:</xsl:text>

						</td>
					</tr>
				</xsl:if>

				<tr>
					<td>
						<xsl:text>E-mail</xsl:text>
						<span class="req">
							<xsl:text> *</xsl:text>
						</span>
					</td>
					<td>
						<input type="text" name="login" class="required" rel="email" value="&e-mail;" onfocus="javascript: if(this.value == '&e-mail;') this.value = '';" onblur="javascript: if(this.value == '') this.value = '&e-mail;';" />
					</td>
				</tr>


				<tr>
					<td>
						<xsl:text>&password;</xsl:text>
						<span class="req">
							<xsl:text> *</xsl:text>
						</span>
					</td>
					<td>
						<input type="password" name="password" class="required" rel="pass" value="&password;" onfocus="javascript: if(this.value == '&password;') this.value = '';" onblur="javascript: if(this.value == '') this.value = '&password;';" />
					</td>
				</tr>


				<tr>
					<td colspan="2" class="lc">
						<a href="/forget">Напомнить пароль</a>
						<a href="/registrate" class="ml10">Регистрация</a>
						<br />
						<p class="mt10">
							<span class="req">*</span>
							<xsl:text> Обязательные поля</xsl:text>
						</p>
						<a href="#" class="btn large-btn ib mt20 linkSubmit" rel="authForm">Войти</a>
					</td>
				</tr>

			</table>
		</form>

	</xsl:template>

</xsl:stylesheet>