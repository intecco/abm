<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="udata[@module = 'system' and @method = 'captcha']" />
	<xsl:template match="udata[@module = 'system' and @method = 'captcha' and count(url)]">

		<img src="{url}{url/@random-string}" id="captcha_img" title="&reset-captcha;" style="cursor:pointer;margin: 10px 0 -10px 25px;" />
		<p class="mt10 mb5">
			<xsl:text>Введите символы с картинки</xsl:text>
		</p>
		<input type="text" name="captcha" class="itext required" />
	</xsl:template>


	<xsl:template match="udata[@module = 'system' and @method = 'captcha']" mode="reg" />
	<xsl:template match="udata[@module = 'system' and @method = 'captcha' and count(url)]" mode="reg">

		<tr>
			<td>
				<xsl:text>Введите символы с картинки</xsl:text>
				<span class="req">
					<xsl:text> *</xsl:text>
				</span>
			</td>
			<td>
				<img src="{url}{url/@random-string}" id="captcha_img" title="&reset-captcha;" style="cursor:pointer;margin:10px 0 5px 45px;display:block;" />
				<input type="text" name="captcha" class="required" />
			</td>
		</tr>
	</xsl:template>



</xsl:stylesheet>