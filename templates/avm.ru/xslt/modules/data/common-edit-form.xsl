<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--### START Edit form -->
	<xsl:template match="udata[@method = 'getCreateForm' or @method = 'getEditForm']" mode="editForm">
		<xsl:param name="with-req" />
		<xsl:apply-templates select="group" mode="form">
			<xsl:with-param name="with-req" select="$with-req" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="group" mode="form">
		<xsl:param name="with-req" />
		<xsl:apply-templates select="field[not(@name='lname') and not(@name='father_name')]" mode="commonTemplate">
			<xsl:with-param name="with-req" select="$with-req" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="field" mode="commonTemplate">
		<xsl:param name="with-req" />
		<tr>
			<td>
				<xsl:choose>
					<xsl:when test="$with-req">
						<xsl:value-of select="@title" />
						<xsl:if test="@required">
							<span class="req">
								<xsl:text> *</xsl:text>
							</span>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<b>
							<xsl:value-of select="@title" />
						</b>
					</xsl:otherwise>
				</xsl:choose>

			</td>
			<td>
				<xsl:if test="@type='date'">
					<xsl:attribute name="class"><xsl:text>edit-date</xsl:text></xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="form" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="field" mode="form">
		<input type="text" name="{@input_name}" value="{.}" class="{@required}" rel="{@name}" />
	</xsl:template>

	<xsl:template match="field[@type = 'date']" mode="form">
		<xsl:variable name="day" select="document(concat('udata://system/convertDate/',@timestamp,'/(d)'))/udata" />
		<xsl:variable name="month" select="document(concat('udata://system/convertDate/',@timestamp,'/(m)'))/udata" />
		<xsl:variable name="year" select="document(concat('udata://system/convertDate/',@timestamp,'/(Y)'))/udata" />

		<input type="hidden" name="{@input_name}" />
		<span class="ib mr10">ДД</span>
		<input type="text" maxlength="2" class="date-day" value="{$day}" />
		<span class="ib ml10 mr10">ММ</span>
		<input type="text" maxlength="2" class="date-month" value="{$month}" />
		<span class="ib ml10 mr10">ГГ</span>
		<input type="text" maxlength="4" class="date-year" value="{$year}" />
	</xsl:template>

	<xsl:template match="field[@type = 'relation']" mode="form">
		<select name="{@input_name}" class="{@required}" rel="select">
			<xsl:if test="@multiple = 'multiple'">
				<xsl:attribute name="multiple">multiple</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="values/item" mode="form" />
		</select>
	</xsl:template>

	<xsl:template match="item" mode="form">
		<option value="{@id}">
			<xsl:copy-of select="@selected" />
			<xsl:value-of select="." />
		</option>
	</xsl:template>


	<xsl:template match="field[@type = 'boolean']" mode="form">
		<input type="hidden" name="{@input_name}" value="0" />
		<input type="checkbox" name="{@input_name}" value="1" class="{@required}">
			<xsl:copy-of select="@checked" />
		</input>
	</xsl:template>


	<xsl:template match="field[@type = 'text' or @type = 'wysiwyg']" mode="form">
		<textarea name="{@input_name}" class="{@required}" rel="textArea">
			<xsl:value-of select="." />
		</textarea>
	</xsl:template>


	<xsl:template match="field[@type = 'file' or @type = 'img_file']" mode="form">
		<input type="file" name="{@input_name}" class="{@required}" rel="file" />
	</xsl:template>

	<!--### START END form -->
</xsl:stylesheet>