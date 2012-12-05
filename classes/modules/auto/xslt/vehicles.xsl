<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:udt="http://umi-cms.ru/2007/UData/templates"
				xmlns:umi="http://www.umi-cms.ru/TR/umi">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

  <!-- Подключение шаблона для отображения формы поиска -->
  <xsl:include href="inc_form.xsl"/>

  <!-- Подключение шаблона для отображения постраничной навигации -->
  <xsl:include href="inc_pagination.xsl"/>

  <!--
    Поскольку посчитать количество автомобилей необходимо для нескольких
    задач в шаблоне, сохраним результат расчета в переменной.
  -->
  <xsl:variable name="count" select="count(/response/vehicles/vehicle)"/>

  <xsl:template match="/">
  <div class="ml40">
<h2 class="mt30 mb20">Автомобили</h2>
    <!-- Правило для корневого элемента. Отсюда стартует преобразование. -->
    <h1></h1>

    <!-- Форма поиска -->
    <xsl:apply-templates select="/response/search_form"/>

    <!-- Принудительно выводим только ноды, вложенные в vehicles -->
    <xsl:apply-templates select="/response/vehicles"/>
	</div>
  </xsl:template>

  <!-- Преобразование списка автомобилей -->
  <xsl:template match="vehicles">
    <section class="mt30 goods-area">
      <xsl:choose>
        <xsl:when test="$count > 0">
         
          <xsl:apply-templates select="/response/vehicles/vehicle[position()>(($page - 1)*$rows) and ($page*$rows)>=position()]"/>

          <!-- Вывод ссылок для постраничной навигации-->
          <xsl:call-template name="Navigation"/>
        </xsl:when>
        <xsl:otherwise>
          <p>Не найдено ни одного автомобиля</p>
        </xsl:otherwise>
      </xsl:choose>
    </section>
  </xsl:template>

  <!-- Преобразование для конкретного автомобиля -->
  <xsl:template match="vehicle">
  <div class="good-card ib mr10 mb40">
<h3><a href="./detail/{@vehicle_id}/"><xsl:value-of select="./model" /></a></h3>
<div class="ib mt20 fc">
<a href="./detail/{@vehicle_id}/">
<img width="162" height="122" alt="" class="imageborder">
          <xsl:attribute name="src">
            <xsl:choose>
              <!-- Если есть фото, выводим его -->
              <xsl:when test="./photo/thumbnail">
			  <xsl:variable name="GETIMG" select="document(concat('udata://auto/getpic/',./photo/@file_name, '/',@dealer_id,'/',@vehicle_id))/udata/value" />
			  <xsl:variable name="CFGPG" select="document(concat('udata://system/makeThumbnailFull/(./',$GETIMG,')/162/122/notemplate/0/1'))/udata/src" />
                <xsl:value-of select="$CFGPG" />
              </xsl:when>
              <!-- Если фото у автомобиля нет, выводим заглушку -->
              <xsl:otherwise>
                <xsl:text>/css/img/nophoto.png</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </img>
</a><p class="price mt10"> <xsl:choose>
              <xsl:when test="./price/value/@unit = 'eur'">
                <xsl:text>€ </xsl:text>
                <xsl:value-of select="./price/value" />
              </xsl:when>
              <xsl:when test="./price/value/@unit = 'usd'">
                <xsl:text>$ </xsl:text>
                <xsl:value-of select="./price/value" />
              </xsl:when>
              <xsl:when test="./price/value/@unit = 'rub'">
                <xsl:value-of select="./price/value" />
                <xsl:text> руб.</xsl:text>
              </xsl:when>
            </xsl:choose></p>

</div>
<div class="ib mt20 ml5 characteristic">
<p class="mb10"><b class="ib mr10">Объем двигателя </b><span class="ib"><xsl:value-of select="./engine/volume " /></span></p>
<p class="mb10"><b class="ib mr10">Год выпуска</b><span class="ib"><xsl:value-of select="./year" /></span></p>
<p class="mb10"><b class="ib mr10">КПП</b><span class="ib"><xsl:value-of select="./gearbox/type" /></span></p>
<p class="mb10"><b class="ib mr10">Привод</b><span class="ib"><xsl:value-of select="./drive/type" /></span></p>
<p class="mb10"><b class="ib mr10">Пробег, км</b><span class="ib"><xsl:value-of select="./mileage/value" /></span></p>
</div>
</div>
  
   
  </xsl:template>
</xsl:stylesheet>
