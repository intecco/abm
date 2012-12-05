<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="/" mode="layout">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>

		<xsl:comment>
			[if lt IE 7]&gt;&lt;html class="no-js ie6 oldie"
			lang="en"&gt;&lt;![endif]
		</xsl:comment>

		<xsl:comment>
			[if IE 7]&gt;&lt;html class="no-js ie7 oldie"
			lang="en"&gt;&lt;![endif]
		</xsl:comment>

		<xsl:text disable-output-escaping="yes">
                  &lt;!--[if IE 8]&gt;&lt;html class="no-js ie8 oldie" lang="en"&gt;&lt;![endif]&gt;
		</xsl:text>


		<xsl:text disable-output-escaping="yes">a
                    &lt;!--[if gt IE 8]&gt;&lt;!--&gt;
		</xsl:text>

		<html class="no-js" lang="ru">
			<xsl:text disable-output-escaping="yes">
                   &lt;![endif]&gt;
		</xsl:text>

			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta name="keywords" content="{//meta/keywords}" />
				<meta name="description" content="{//meta/description}" />
				<meta name="author" content="" />
				<meta name="viewport" content="width=1024" />

				<title>
					<xsl:value-of select="$document-title" />
				</title>
				<script src="/templates/sharon.ru/js/libs/modernizr-2.0.6.min.js" />
				<script src="/templates/sharon.ru/js/libs/jquery-1.6.2.min.js" />
				<script src="/templates/sharon.ru/js/scripts.js" />
				<script charset="utf-8"
					src="/js/site/__common.js?{/result/@system-build}" type="text/javascript"></script>

				<link rel="canonical"
					href="http://{concat(result/@domain, result/@request-uri)}" />

				<link rel="stylesheet" href="/templates/sharon.ru/css/style.css" />



			</head>
			<body>
				<div class="topLine">
					<div>
						<a href="../">←Вернуться к разделам</a>
					</div>
				</div>
				<div class="thumbLine cf">
					<xsl:apply-templates select="document(concat('usel://getChildPage/',result/page/@parentId,'/5'))/udata/page" mode="commonGallery" />
				</div>
				<span class="gprev"><!-- -->
				</span>
				<span class="gnext"><!-- -->
				</span>
				<div class="gallery"></div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="page" mode="commonGallery">
		<xsl:variable name="curr"
			select="document(concat('upage://',@id))/udata/page" />
		<xsl:variable name="photoProp" select="$curr//property[@name='photo']/value" />
		<xsl:if test="$photoProp">
			<a href="{$photoProp}">
				<xsl:if test="$document-page-id = @id">
					<xsl:attribute name="class"><xsl:text>act</xsl:text></xsl:attribute>
				</xsl:if>
				<xsl:call-template name="catalog-thumbnail">
					<xsl:with-param name="element-id" select="@id" />
					<xsl:with-param name="field-name">
						<xsl:text>photo</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="width">
						<xsl:text>97</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="height">
						<xsl:text>57</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="alt">
						<xsl:value-of select="$curr//property[@name='alt_photo']/value" />
					</xsl:with-param>
				</xsl:call-template>
			</a>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>