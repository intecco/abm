<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--### START Catalog filters -->
	<xsl:template match="udata[@method = 'search_custom'][group]" mode="catalogFilter">



		<xsl:if test="count(.//field) &gt; 0">
			<form class="auto-filter filter mb80" id="filterForm">
				<a href="{$curr-result/page/@link}" class="clean-filter mb15">Очистить фильтр</a>
				<table>
					<tr>
						<xsl:apply-templates select=".//group[not(@name='cenovye_svojstva')]" mode="commonTemplate" />
					</tr>
				</table>
				<a href="#" id="filterFormLink" class="btn large-btn ib mt15 fr">Отфильтровать</a>
			</form>
		</xsl:if>
	</xsl:template>

	<xsl:template match="group" mode="commonTemplate">

		<xsl:variable name="countFileds" select="count(.//field)" />
		<xsl:variable name="divider">
			<xsl:choose>
				<xsl:when test="count(.//field) &gt; 6">
					<xsl:text>3</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>2</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="middleMax" select="ceiling($countFileds div $divider)" />


		<!-- First column -->
		<td>
			<xsl:apply-templates select=".//field[position() &lt; $middleMax+1]" mode="commonTemplate" />

		</td>

		<xsl:choose>
			<xsl:when test="$divider = 2">
				<!-- Second column -->
				<td class="lc">
					<xsl:apply-templates select=".//field[position() &gt; $middleMax]" mode="commonTemplate" />
				</td>


			</xsl:when>
			<xsl:when test="$divider = 3">
				<xsl:variable name="middleMin" select="round($countFileds div $divider)" />
				<xsl:variable name="secondPosition" select="$middleMax+$middleMin" />
				<!-- Second column -->
				<td class="middle-column">
					<xsl:apply-templates select=".//field[position() &gt; $middleMax and position() &lt; $secondPosition+1]" mode="commonTemplate" />
				</td>
				<td class="lc">
					<xsl:apply-templates select=".//field[position() &gt; $secondPosition]" mode="commonTemplate" />
				</td>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="field[@guide_host and not(@date-type='boolean') and not(@single)]" mode="commonTemplate">
		<div class="double-select mt10">
			<p>
				<label class="select-name ib">
					<xsl:value-of select="@title" />
				</label>
				<p class="ib mt10 selectStaticWidth">
					<label>От</label>
					<select class="changeselect" name="fields_filter[{@name}][0]">

						<xsl:call-template name="propertySelect">
							<xsl:with-param name="currField" select="." />
						</xsl:call-template>

						<xsl:apply-templates select="document(concat('usel://getGuideItems/',@guide_host))/udata/item" mode="hostOption">
							<xsl:with-param name="active" select="value_from" />
						</xsl:apply-templates>
					</select>
				</p>

				<p class="ib ml10 mt10 selectStaticWidth" rel="{@guide_host}">
					<label>До</label>
					<select class="changeselect" name="fields_filter[{@name}][1]">

						<xsl:call-template name="propertySelect">
							<xsl:with-param name="currField" select="." />
						</xsl:call-template>

						<xsl:apply-templates select="document(concat('usel://getGuideItems/',@guide_host))/udata/item" mode="hostOption">
							<xsl:with-param name="active" select="value_to" />
						</xsl:apply-templates>
					</select>
				</p>

			</p>
		</div>
	</xsl:template>

	<xsl:template match="field[@guide_host and (@data-type='boolean' or @single=1)]" mode="commonTemplate">

		<p class="mt10  single-select">
			<label class="select-name ib">
				<xsl:value-of select="@title" />
			</label>
			<select class="changeselect mt10" name="fields_filter[{@name}]">

				<xsl:call-template name="propertySelect">
					<xsl:with-param name="currField" select="." />
				</xsl:call-template>

				<option value="">
					<xsl:text>Не важно</xsl:text>
				</option>
				<xsl:apply-templates select="document(concat('usel://getGuideItems/',@guide_host))/udata/item" mode="hostOption" />
			</select>
		</p>

	</xsl:template>


	<xsl:template match="field[not(@guide_host) and @data-type='relation']" mode="commonTemplate">

		<xsl:if test="count(values/item) &gt; 0">
			<p class="mt10  single-select">
				<label class="select-name ib">
					<xsl:value-of select="@title" />
				</label>
				<select class="changeselect mt10" name="fields_filter[{@name}]">

					<xsl:call-template name="propertySelect">
						<xsl:with-param name="currField" select="." />
					</xsl:call-template>


					<option value="">
						<xsl:text>Не важно</xsl:text>
					</option>
					<xsl:apply-templates select="values/item" mode="option" />
				</select>
			</p>
		</xsl:if>
	</xsl:template>

	<xsl:template match="item" mode="option">
		<option value="{@id}">
			<xsl:copy-of select="@selected" />
			<xsl:value-of select="." />
		</option>
	</xsl:template>

	<xsl:template match="item" mode="hostOption">
		<xsl:param name="active" />
		<xsl:variable name="currObj" select="document(concat('uobject://',@id))/udata/object" />
		<option value="{@name}" rel="{$active}">
			<xsl:if test="$currObj//property[@name='valid_value']/value">
				<xsl:attribute name="value"><xsl:value-of select="$currObj//property[@name='valid_value']/value" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$active = @name or $active = $currObj//property[@name='valid_value']/value">
				<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="@name" />
		</option>
	</xsl:template>
	<!--### END Catalog filters -->



	<!--### START Sort block -->
	<xsl:template name="sortBlock">
		<form class="simple-filter" id="sortForm">
			<p class="ib type">
				<label class="ib mr20">Сортировка</label>
				<select class="changeselect" name="sort">
					<option value="">
						<xsl:text>По новизне</xsl:text>
					</option>
					<option value="h1">
						<xsl:if test="$sort='h1'">
							<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:text>
							По имени
						</xsl:text>
					</option>
					<option value="price">
						<xsl:if test="$sort='price'">
							<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:text>
							По цене
						</xsl:text>
					</option>
				</select>
			</p>

			<p class="ib number ml40">
				<select class="changeselect" name="limit">
					<option value="10">
						<xsl:if test="$limit='10'">
							<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:text>10</xsl:text>
					</option>
					<option value="20">
						<xsl:if test="$limit='20'">
							<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:text>20</xsl:text>
					</option>
					<option value="50">
						<xsl:if test="$limit='50'">
							<xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:text>50</xsl:text>
					</option>
				</select>
				<label class="ib ml20">товаров на странице</label>
			</p>
		</form>
	</xsl:template>


	<xsl:template name="propertySelect">
		<xsl:param name="currFiled" />

		<xsl:if test="@important">
			<xsl:attribute name="rel">
				<xsl:text>important</xsl:text>
			</xsl:attribute>

			<xsl:attribute name="src" select="">
				<xsl:value-of select="@name" />
			</xsl:attribute>
		</xsl:if>

		<xsl:if test="@depend">
			<xsl:attribute name="rel">
				<xsl:text>depend</xsl:text>
			</xsl:attribute>

			<xsl:attribute name="src" select="">
				<xsl:value-of select="@depend_filed" />
			</xsl:attribute>
		</xsl:if>

		<xsl:if test="@guide_selft">
			<xsl:attribute name="href" select="">
				<xsl:value-of select="@guide_selft" />
			</xsl:attribute>
		</xsl:if>


	</xsl:template>
	<!--### END Sort block -->

</xsl:stylesheet>