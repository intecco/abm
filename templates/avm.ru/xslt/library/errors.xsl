<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="udata[@module = 'system' and @method = 'listErrorMessages']" />

	<xsl:template match="udata[@module = 'system' and @method = 'listErrorMessages'][count(items/item) &gt; 0]">
		
			<tr class="error-tr">
		
				<xsl:apply-templates select="items/item" mode="error" />
			</tr>
		
	</xsl:template>
	
	<xsl:template match="item" mode="error">
		<td colspan="2">
			<xsl:value-of select="." />
		</td>
	</xsl:template>


	<xsl:template match="error">
		
			<tr class="error-tr">
			
				<td colspan="2">
					<xsl:value-of select="." />
				</td>
			</tr>
	
	</xsl:template>
</xsl:stylesheet>