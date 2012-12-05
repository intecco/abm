<?xml version="1.0" encoding="utf-8"?>
<!--DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file" -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template match="send_message">
		<xsl:variable name="pageObj" select="document(concat('upage://',pageId))/udata/page"/>
		<html>
				<head>
					
				</head>
				<body>
					Добавлен новый комментарий.
					<br />
					<br />
					<a href="http://{domain}/comments/edit/{messageId}">Посмотреть комментарий</a>
					<br />
					<a href="http://{domain}/{$pageObj/@link}">Ответить</a>
					
				</body>
			</html>
	</xsl:template>

</xsl:stylesheet>