<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

  <xsl:include href="inc_form.xsl" />

  <xsl:template match="/">
    <h1>Ошибка в параметрах поиска</h1>
    <xsl:apply-templates />
  </xsl:template>

</xsl:stylesheet>