<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output encoding="utf-8" method="html" indent="yes" />
	<xsl:include href="../../modules/faq/category.xsl" />

	<xsl:template match="main">
		<xsl:apply-templates select="document(concat('udata://faq/category/notemplate/',cat_id))/udata">
			<xsl:with-param name="catId" select="cat_id" />
		</xsl:apply-templates>
	</xsl:template>

</xsl:stylesheet>