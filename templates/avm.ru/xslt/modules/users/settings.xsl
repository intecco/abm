<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">

	<xsl:template match="result[@method = 'settings']">
		<xsl:apply-templates select="document('udata://content/redirect/(/personal/data/)')/udata" />
	</xsl:template>

	<xsl:template match="result[@method = 'personal']">
		<xsl:apply-templates select="document('udata://content/redirect/(/personal/data/)')/udata" />
	</xsl:template>


	<!--### START Show settings -->
	<xsl:template match="udata" mode="justShowData">
		<xsl:variable name="chkDisp" select="document('udata://dispatches/checkUser')/udata/id" />
		<table class="personal-data">
			<xsl:apply-templates select=".//group[@name='short_info']/property" mode="showData" />
		</table>


		<xsl:choose>
			<xsl:when test="$chkDisp = 'none'">
				<div class="mt15">
					<p class="ib">Вы еще не подписаны на уведомления о спецпредложениях</p>
					<a href="/udata/dispatches/subscribe_custom/" class="ib ml20 dispatche-link">Подписаться</a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="mt15">
					<p class="ib">Подписан на уведомления о спецпредложениях</p>
					<a href="/udata/dispatches/unsubscribe_custom/{$chkDisp}" class="ib ml20 dispatche-link" rel='delete'>Отписаться</a>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<a href="?data_edit=1" class="mt25 btn large-btn ib">Редактировать личные данные</a>
	</xsl:template>

	<xsl:template match="property" mode="showData">
		<tr>
			<td>
				<b>
					<xsl:value-of select="title" />
				</b>
			</td>
			<td>
				<xsl:apply-templates select="value" mode="showDate" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="value" mode="showDate">
		<xsl:value-of select="." disable-output-escaping="yes" />
	</xsl:template>

	<xsl:template match="value[count(item) &gt; 0]" mode="showDate">
		<xsl:value-of select="item" mode="itemShowDate" />
	</xsl:template>

	<xsl:template match="item" mode="itemShowDate">
		<xsl:value-of select="@name" />
		<xsl:if test="position()!=last()">
			&#160;
		</xsl:if>
	</xsl:template>

	<xsl:template match="value[@unix-timestamp]" mode="showDate">
		<xsl:value-of select="document(concat('udata://system/convertDate/',@unix-timestamp,'/(d.m.Y)'))/udata" />
	</xsl:template>
	<!--### END Show settings -->



	<!--### START Edit settings -->
	<xsl:template match="udata" mode="editPersonalData">

		<form enctype="multipart/form-data" method="post" action="{$lang-prefix}/users/settings_do/" id="editForm">
		<input type="hidden" name="from_page" value="{$curr-result/page/@link}"/>
			<table class="edit-personal-data">
				<xsl:apply-templates select="document(concat('udata://data/getEditForm/', $user-id,'/notemplate/(short_info)'))" mode="editForm" />
				
				<tr>
					<td>
						<b>E-mail</b>
					</td>
					<td>
						<input type="text" name="email" value="{$user-info//property[@name = 'e-mail']/value}" />
					</td>
				</tr>
				<tr>
					<td>
						<b>
							<xsl:text>&password;</xsl:text>
						</b>
					</td>
					<td>
						<input type="password" name="password" />
					</td>
				</tr>

				<tr>
					<td>
						<b>
							<xsl:text>&password-confirm;</xsl:text>
						</b>
					</td>
					<td>
						<input type="password" name="password_confirm" />
					</td>
				</tr>


				<tr>
					<td colspan="2" class="lc">

						<a href="#" class="mt25 btn large-btn ib linkSubmit" rel="editForm">Сохранить</a>
					</td>
				</tr>
			</table>






		</form>
	</xsl:template>
	<!--### END Edit settings -->


</xsl:stylesheet>