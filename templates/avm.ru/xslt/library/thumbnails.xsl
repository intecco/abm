<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template name="preResize">
		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="empty" />
		<xsl:param name="width">
			<xsl:text>>auto</xsl:text>
		</xsl:param>
		<xsl:param name="height">
			<xsl:text>auto</xsl:text>
		</xsl:param>
		<xsl:param name="alt" />
		<xsl:param name="class" />

		<xsl:variable name="img_params_type">
			<xsl:value-of select="document(concat('udata://custom/getOptimalImageParams/',$element-id,'/',$field-name,'/',$width,'/',$height,'/'))/udata/type" />
		</xsl:variable>

		<xsl:variable name="img_params_size">
			<xsl:value-of select="document(concat('udata://custom/getOptimalImageParams/',$element-id,'/',$field-name,'/',$width,'/',$height,'/'))/udata/size" />
		</xsl:variable>

		<xsl:variable name="widthRes">
			<xsl:choose>
				<xsl:when test="$img_params_type = 'width'">
					<xsl:value-of select="$img_params_size" />
				</xsl:when>
				<xsl:when test="$img_params_type = 'height'">
					<xsl:text>auto</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="heightRes">
			<xsl:choose>
				<xsl:when test="$img_params_type = 'height'">
					<xsl:value-of select="$img_params_size" />
				</xsl:when>
				<xsl:when test="$img_params_type = 'width'">
					<xsl:text>auto</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:call-template name="catalog-thumbnail">
			<xsl:with-param name="element-id" select="$element-id" />
			<xsl:with-param name="field-name" select="$field-name" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="class" select="$class" />

			<xsl:with-param name="width" select="$widthRes" />


			<xsl:with-param name="height" select="$heightRes" />

		</xsl:call-template>


	</xsl:template>

	<xsl:template name="catalog-thumbnail">
		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="empty" />
		<xsl:param name="width">
			<xsl:text>>auto</xsl:text>
		</xsl:param>
		<xsl:param name="height">
			<xsl:text>auto</xsl:text>
		</xsl:param>
		<xsl:param name="alt" />
		<xsl:param name="class" />




		<xsl:variable name="property" select="document(concat('upage://', $element-id, '.', $field-name))/udata/property" />

		<xsl:call-template name="thumbnail">


			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />

			<xsl:with-param name="element-id" select="$element-id" />
			<xsl:with-param name="field-name" select="$field-name" />
			<xsl:with-param name="empty" select="$empty" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="src">
				<xsl:choose>
					<xsl:when test="$property/value">
						<xsl:value-of select="$property/value" />
					</xsl:when>
					<xsl:otherwise>&empty-photo;
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="class" select="$class" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="thumbnail">
		<xsl:param name="src" />
		<xsl:param name="width">
			<xsl:text>auto</xsl:text>
		</xsl:param>
		<xsl:param name="height">
			<xsl:text>auto</xsl:text>
		</xsl:param>
		<xsl:param name="empty" />
		<xsl:param name="class" />

		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="alt" />
		<xsl:apply-templates select="document(concat('udata://system/makeThumbnailFull/(.', $src, ')/', $width, '/', $height, '/void/0/1/'))/udata">
			<xsl:with-param name="element-id" select="$element-id" />
			<xsl:with-param name="field-name" select="$field-name" />
			<xsl:with-param name="empty" select="$empty" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="class" select="$class" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and (@method = 'makeThumbnail' or @method = 'makeThumbnailFull')]">
		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="empty" />
		<xsl:param name="alt" />
		<xsl:param name="class" />

		<img src="{src}" width="{width}" height="{height}" alt="{$alt}">
			<xsl:if test="$element-id and $field-name">
				<xsl:attribute name="umi:element-id">
					<xsl:value-of select="$element-id" />
				</xsl:attribute>

				<xsl:attribute name="umi:field-name">
					<xsl:value-of select="$field-name" />
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="$empty">
				<xsl:attribute name="umi:empty">
					<xsl:value-of select="$empty" />
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$class">
				<xsl:attribute name="class">
					<xsl:value-of select="$class" />
				</xsl:attribute>
			</xsl:if>
		</img>
	</xsl:template>
</xsl:stylesheet>