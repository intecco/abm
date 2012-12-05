<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">

	<xsl:output encoding="utf-8" method="html" indent="yes" />

	<xsl:variable name="errors" select="document('udata://system/listErrorMessages')/udata" />

	<xsl:variable name="lang-prefix" select="/result/@pre-lang" />
	<xsl:variable name="document-page-id" select="/result/@pageId" />
	<xsl:variable name="document-title" select="/result/@title" />
	<xsl:variable name="user-type" select="/result/user/@type" />
	<xsl:variable name="request-uri" select="/result/@request-uri" />
	<xsl:variable name="domain" select="/result/@domain" />
	<xsl:variable name="curr-result" select="/result" />


	<xsl:variable name="site-info-id" select="document('upage://contacts')/udata/page/@id" />
	<xsl:variable name="site-info" select="document('upage://contacts')//group[@name = 'site_info']/property" />
	<xsl:variable name="comparePage" select="document('upage://compare')/udata/page" />
	<xsl:variable name="cart_items" select="document('udata://emarket/cart/')/udata/items" />

	<xsl:variable name="user-id" select="/result/user/@id" />
	<xsl:variable name="user-info" select="document(concat('uobject://', $user-id))" />

	<xsl:variable name="module" select="/result/@module" />
	<xsl:variable name="method" select="/result/@method" />

	<xsl:param name="p">
		<xsl:text>0</xsl:text>
	</xsl:param>
	<xsl:param name="search_string" />
	<xsl:param name="template-resources" />
	<xsl:param name="sort" />
	<xsl:param name="limit">
		<xsl:text>10</xsl:text>
	</xsl:param>

	<xsl:param name="data_edit" />
	<xsl:param name="product_type" />
	<xsl:param name="error_auth" />
	<xsl:param name="show_order" />
	<xsl:param name="order_id" />
	

	<xsl:include href="layouts/print.xsl" />
	<xsl:include href="library/common.xsl" />

	<xsl:include href="modules/emarket/common.xsl" />
	<xsl:include href="modules/content/contacts.xsl" />


</xsl:stylesheet>