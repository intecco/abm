<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--### START Header -->
	<xsl:template name="header">
		<h2 class="mt30 mb20" umi:element-id="{$document-page-id}" umi:field-name="h1">
			<xsl:value-of select=".//property[@name='h1']/value" />
		</h2>
	</xsl:template>
	<!--### END Header -->



	<!--### START Top menu -->
	<xsl:template match="udata" mode="top_menu">
		<nav>
			<ul class="ib mt20 ml40" umi:element-id="0" umi:module="content" umi:add-method="popup" umi:region="list" umi:sortable="sortable">
				<xsl:apply-templates select="items/item" mode="menu_top_li" />
			</ul>
		</nav>
	</xsl:template>

	<xsl:template match="item" mode="menu_top_li">
		<xsl:param name="right" />
		<li class="ib" umi:element-id="{@id}" umi:region="row">
			<a href="{@link}" umi:field-name="name" umi:empty="&empty-section-name;" umi:delete="delete">
				<xsl:choose>
					<xsl:when test="position()= 1">
						<xsl:attribute name="class"><xsl:text>fc</xsl:text></xsl:attribute>
					</xsl:when>
					<xsl:when test="position()= last()">
						<xsl:attribute name="class"><xsl:text>lc</xsl:text></xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:template>
	<!--### END Top menu -->


	<!--### START Left menu -->
	<xsl:template name="leftMenu">
		<xsl:variable name="mainCatalogPage" select="document('udata://custom/getPageId/110')/udata/page" />
		<ul class="goods-categories-widget" umi:element-id="{$mainCatalogPage/@id}" umi:module="catalog" umi:region="list" umi:sortable="sortable">
			<xsl:apply-templates select="document(concat('udata://content/menu/notemplate/0/',$mainCatalogPage/@id))/udata" mode="leftMenu" />
		</ul>
	</xsl:template>

	<xsl:template match="udata" mode="leftMenu">
	<li><a href="/auto/" class="current" style="background: url('/images/cms/menu/1-catside-ico.png') no-repeat">Автомобили</a></li>
		<xsl:apply-templates select="items/item" mode="leftMenu" />
	</xsl:template>

	<xsl:template match="item" mode="leftMenu">
		<xsl:variable name="curr" select="document(concat('upage://',@id))/udata" />
		<xsl:variable name="bckImg" select="$curr//property[@name='menu_pic_ua']/value" />
		<xsl:variable name="subMenu" select="document(concat('udata://content/menu/notemplate/0/',@id))/udata/items" />

		<li umi:element-id="{@id}" umi:region="row">
			<xsl:if test="@status='active'">
				<xsl:attribute name="class"><xsl:text>current</xsl:text></xsl:attribute>
			</xsl:if>
			<a href="{@link}" class="current" style="background: url('{$bckImg}') no-repeat" umi:field-name="name" umi:empty="&empty-section-name;" umi:delete="delete">
				<xsl:if test="@status='active'">
					<xsl:attribute name="class"><xsl:text>current</xsl:text></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="." />
			</a>
			<xsl:if test="@status='active'">
				<div class="arrow"></div>
			</xsl:if>

			<xsl:if test="count($subMenu/item) &gt; 0">
				<ul class="submenu">
					<xsl:apply-templates select="$subMenu/item" mode="subMenu" />
				</ul>
			</xsl:if>


		</li>
	</xsl:template>

	<xsl:template match="item" mode="subMenu">
		<li>
			<xsl:if test="position() = last()">
				<xsl:attribute name="class"><xsl:text>lastLi</xsl:text></xsl:attribute>
			</xsl:if>
			<a href="{@link}">
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:template>
	<!--### END Left menu -->



	<!--### START Left bottom menu choose -->
	<xsl:template name="leftBottomMenu">
		<xsl:choose>
			<xsl:when test="$curr-result/page/@is-default">
				<xsl:call-template name="mainBottomMenu" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="otherBottomMenu" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="mainBottomMenu">
		<xsl:variable name="contactPage" select="document('udata://custom/getPageId/112')/udata/page" />
		<xsl:variable name="chortDesc" select="document(concat('upage://',$contactPage/@id,'.anons_text_main'))/udata/property/value" />
		<article class="mt40">
			<h2>
				<a href="{$contactPage/@link}" umi:element-id="{$contactPage/@id}" umi:field-name="h1" umi:empty="&empty-page-content;">
					<xsl:value-of select="$contactPage/name" />
				</a>
			</h2>
			<p class="mt20 mb20" umi:element-id="{$contactPage/@id}" umi:field-name="anons_text_main" umi:empty="&empty-page-content;">
				<xsl:value-of select="$chortDesc" disable-output-escaping="yes" />
			</p>
			<a href="{$contactPage/@link}" class="fullstory">
				<xsl:text>Полный текст</xsl:text>
			</a>
		</article>
	</xsl:template>

	<xsl:template name="otherBottomMenu">
		<ul class="bonus-vertical-widget mt30">
			<li class="special-propouses">
				<a href="/special_offers">
					<xsl:text>Специальные предложения</xsl:text>
				</a>
			</li>
			<li class="new">
				<a href="/novelty">
					<xsl:text>Новинки</xsl:text>
				</a>
			</li>
			<li class="credits lc">
				<a href="/credit">
					<xsl:text>Кредит</xsl:text>
				</a>
			</li>
		</ul>
	</xsl:template>
	<!--### END Left bottom menu choose -->



	<!--### START Breadcrumbs -->
	<xsl:template name="breadcrumbs">
		<xsl:choose>
			<xsl:when test="not($curr-result/page/@id-default)">
				<xsl:apply-templates select="document('udata://core/navibar/')/udata" mode="breadcrumbs" />
			</xsl:when>
			<xsl:otherwise />
		</xsl:choose>
	</xsl:template>

	<xsl:template match="udata" mode="breadcrumbs">
		<xsl:if test="count(items/item) &gt; 0 and items/item[position()=last()]/@link != '/'">
			<ul class="breadcrumbs fr">
				<li class="ib">
					<a href="/">
						<xsl:text>Главная</xsl:text>
					</a>
				</li>
				<li class="ib">
					<p>/</p>
				</li>
				<xsl:apply-templates select="items/item" mode="breadcrumbsItem" />
			</ul>
		</xsl:if>
	</xsl:template>

	<xsl:template match="item" mode="breadcrumbsItem">
		<li class="ib">
			<a href="{@link}">
				<xsl:value-of select="." />
			</a>
		</li>
		<li class="ib">
			<p>/</p>
		</li>
	</xsl:template>

	<xsl:template match="item[position()=last()]" mode="breadcrumbsItem">
		<li class="ib lc">
			<p>
				<xsl:value-of select="." />
			</p>
		</li>
	</xsl:template>
	<!--### END Breadcrumbs -->


	<!--### START class selector -->
	<xsl:template name="classChoose">
		<xsl:choose>
			<xsl:when test="$curr-result/page/@is-default">
				<xsl:attribute name="class"><xsl:text>index-html</xsl:text></xsl:attribute>
			</xsl:when>
			<xsl:when test="$curr-result/page/@type-id = 111 or $curr-result/page/@type-id = 113">
				<xsl:attribute name="class"><xsl:text>contacts-html</xsl:text></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--### END class selector -->




	<!--### START Sub catalog menu -->
	<xsl:template name="subCatalogMenu">
		<xsl:variable name="subMenu" select="document(concat('udata://content/menu/notemplate/0/',$document-page-id))/udata/items/item" />
		<xsl:choose>
			<xsl:when test="count($subMenu) &gt; 0">
				<div class="moto-spare">
					<ul class="spare-categories mb30" umi:element-id="{$document-page-id}" umi:module="content" umi:add-method="none" umi:region="list" umi:sortable="sortable">
						<xsl:apply-templates select="$subMenu" mode="subMenuItem" />
					</ul>
				</div>
			</xsl:when>
			<xsl:when test="count($curr-result/parents/page) &gt; 1">
				<xsl:variable name="subMenuParent" select="document(concat('udata://content/menu/notemplate/0/',$curr-result/parents/page[position()=last()]/@id))/udata/items/item" />
				<div class="moto-spare">
					<ul class="spare-categories mb30" umi:element-id="{$curr-result/parents/page[position()=last()]/@id}" umi:module="content" umi:add-method="none" umi:region="list" umi:sortable="sortable">
						<xsl:apply-templates select="$subMenuParent" mode="subMenuItem2" />
					</ul>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="item" mode="subMenuItem">
		<li class="ib category-smallblock" umi:element-id="{@id}" umi:region="row">
			<a href="{@link}" umi:field-name="h1">
                                <xsl:variable name="menupic" select="document(concat('upage://',@id))//property[@name='header_pic']/value/@path"/>
                                <xsl:variable name="menupic-thumb" select="document(concat('udata://system/makeThumbnail/(',$menupic,')/130/auto'))//src"/>
                               
<!--				<xsl:if test="@status='active'">
					<xsl:attribute name="class"><xsl:text>current</xsl:text></xsl:attribute>
				</xsl:if>-->
                                <span style="margin: 10px 2px; display: inline-block;">
				<xsl:value-of select="." />
                                </span>
                                <xsl:if test="$menupic">
                                    <img src="{$menupic-thumb}"/>
                                </xsl:if>
                                
			</a>
		</li>
	</xsl:template>
         <xsl:template match="item" mode="subMenuItem2">
		<li class="ib category-smallblock" umi:element-id="{@id}" umi:region="row">
			<a href="{@link}" umi:field-name="h1">
                                <!--<xsl:variable name="menupic" select="document(concat('upage://',@id))//property[@name='header_pic']/value/@path"/>-->
                                <!--<xsl:variable name="menupic-thumb" select="document(concat('udata://system/makeThumbnail/(',$menupic,')/130/auto'))//src"/>-->
                               
<!--				<xsl:if test="@status='active'">
					<xsl:attribute name="class"><xsl:text>current</xsl:text></xsl:attribute>
				</xsl:if>-->
                                <span style="margin: 10px 0; display: inline-block;">
				<xsl:value-of select="." />
                                </span>
                                <br/><br/>
                                                           <!--<img src="{$menupic-thumb}"/>-->
			</a>
		</li>
	</xsl:template>
	<!--### END Sub catalog menu -->


	<!--### START Sub content menu -->
	<xsl:template name="subContentMenu">
		<xsl:variable name="subMenu" select="document(concat('udata://content/menu/notemplate/0/',$document-page-id))/udata/items/item" />

		<ul class="personal-data-selector mb30">
			<xsl:choose>
				<xsl:when test="count($subMenu) &gt; 0">

					<xsl:apply-templates select="$subMenu" mode="subMenuItem" />

				</xsl:when>
				<xsl:when test="count($curr-result/parents/page) &gt; 0">

					<xsl:variable name="subMenuParent" select="document(concat('udata://content/menu/notemplate/0/',$curr-result/parents/page[position()=last()]/@id))/udata/items/item" />
					<xsl:apply-templates select="$subMenuParent" mode="subMenuItem" />

				</xsl:when>
			</xsl:choose>
		</ul>

	</xsl:template>

	<!--### END Sub catalog menu -->



</xsl:stylesheet>