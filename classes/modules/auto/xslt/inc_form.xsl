<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:udt="http://umi-cms.ru/2007/UData/templates"
				xmlns:umi="http://www.umi-cms.ru/TR/umi">
  <xsl:template match="search_form">


      <form action="" method="get" class="auto-filter filter mb80" id="filterForm" name="filterForm">
	  <a href="/auto/" class="clean-filter mb15">Очистить фильтр</a>
	  <table><tr>
	  <td>
        <p class="mt10  single-select">
          <xsl:call-template name="field">
		  
            <xsl:with-param name="label" select="'Марка'"/>
            <xsl:with-param name="element" select="./*[@name='search[mark_id]']"/>
			
          </xsl:call-template></p>
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'Модель'"/>
            <xsl:with-param name="element" select="./*[@name='search[model_id]']"/>
          </xsl:call-template>
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'Год выпуска'"/>
            <xsl:with-param name="element" select="./*[@name='search[year_id]']"/>
          </xsl:call-template>
		  </td><td class="middle-column">
          <p class="mt10  single-select">
            <label for="search_price_from">Цена</label>
          </p>
          <div class="span-6 last">
            <xsl:apply-templates select="./*[@name='search[price][from]']"/>
            <label for="search_price_to"> до </label>
            <xsl:apply-templates select="./*[@name='search[price][to]']"/>
            <xsl:call-template name="hidden_field">
              <xsl:with-param name="element" select="./*[@name='search[price][unit]']"/>
            </xsl:call-template>

            <xsl:call-template name="error">
              <xsl:with-param name="element" select="./*[@name='search[price][from]']"/>
            </xsl:call-template>
          </div>
        
       
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'Кузов'"/>
            <xsl:with-param name="element" select="./*[@name='search[body_type]']"/>
          </xsl:call-template>
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'Двигатель'"/>
            <xsl:with-param name="element" select="./*[@name='search[engine_type]']"/>
          </xsl:call-template>
		  </td><td class="lc">
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'КПП'"/>
            <xsl:with-param name="element" select="./*[@name='search[gearbox_type]']"/>
          </xsl:call-template>
          <xsl:call-template name="field">
            <xsl:with-param name="label" select="'Привод'"/>
            <xsl:with-param name="element" select="./*[@name='search[drive_type]']"/>
          </xsl:call-template>
          <div class="span-2">
            <input type="submit" value="Отфильтровать" class="btn large-btn ib mt15 fr"/>
          </div>
          
       
     
</td>
</tr>
</table> </form>




  </xsl:template>

  <xsl:template name="field">
    <xsl:param name="label"/>
    <xsl:param name="element"/>
    <p class="mt10  single-select">
      <label for="{translate($element/@name, '[]','_')}">
        <xsl:value-of select="$label" />
      </label>
    
    
      <xsl:apply-templates select="$element" />
      <xsl:call-template name="error">
        <xsl:with-param name="element" select="$element"/>
      </xsl:call-template>
    </p>
  </xsl:template>

  <xsl:template match="list">
    <xsl:param name="empty_option" select="1" />
    <select name="{@name}" id="{translate(@name, '[]','_')}" class="changeselect mt10">
      <xsl:if test="$empty_option">
        <option value=''>Не важно</option>
      </xsl:if>
      <xsl:apply-templates select="*"/>
    </select>
  </xsl:template>
  
 <xsl:template match="list[@name = 'search[model_id]']"> 
 <script>
 function reloadMark() {
 var markk = document.getElementsByClassName('cuselActive');
 var modtext = document.getElementsByClassName('cuselText');

 
 
 modtext[1].innerHTML = '';
 var auto = '';
 var grp = markk[0].getAttribute('val');
   <xsl:apply-templates select="*"/>
   jQuery("#cusel-scroll-search_model_id").empty();
       jQuery("#cusel-scroll-search_model_id").append(auto);   
    var params = { 
        refreshEl: "#search_model_id", 
        visRows: 5, 
        scrollArrows: true 
}		
    cuSelRefresh(params); 
   }
   </script>
    <select name="{@name}" id="{translate(@name, '[]','_')}" class="changeselect mt10">
           <option value=''></option>
    </select>
  </xsl:template>
  
  <xsl:template match="list[@name = 'search[mark_id]']">
    <xsl:param name="empty_option" select="1" />
    <select name="{@name}" id="{translate(@name, '[]','_')}" class="changeselect mt10" onChange="reloadMark();">
      <xsl:if test="$empty_option">
        <option value=''>Не важно</option>
      </xsl:if>
      <xsl:apply-templates select="*"/>
    </select>
  </xsl:template>

  <xsl:template match="optgroup">
	if (grp == <xsl:value-of select="@mark_id" />) {auto ='<span class="cuselActive" value=""></span><xsl:apply-templates select="./*" mode="addcusel"/>';}

  </xsl:template>
  

  <xsl:template match="option">
    <xsl:copy>
      <xsl:apply-templates select="* | @* |text()" class='877'/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="option" mode="addcusel">
   <span val="{@value}"><xsl:apply-templates select="text()"/></span>
   
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="field">
    <input name="{@name}" id="{translate(@name, '[]','_')}" value="{@value}" size="{@size}" class="span-2" style="padding:3px;"/>
  </xsl:template>

  <xsl:template name="hidden_field">
    <xsl:param name="element"/>
    <xsl:param name="value"/>
    <input name="{$element/@name}" id="{translate($element/@name, '[]','_')}" value="{$value}" type="hidden">
      <xsl:attribute name="value">
        <xsl:choose>
          <xsl:when test="'list' = local-name($element)">
            <xsl:value-of select="$element//option[position() = 1]/@value"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$element/@value"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </input>
  </xsl:template>

  <xsl:template name="error">
    <xsl:param name="element"/>
    <xsl:if test="$element[@error]">
      <div class="error">
        <xsl:value-of select="$element/@error" />
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>