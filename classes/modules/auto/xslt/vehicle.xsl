<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:udt="http://umi-cms.ru/2007/UData/templates"
				xmlns:umi="http://www.umi-cms.ru/TR/umi">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

  <xsl:template match="vehicle">
  <div class="ml40">
<h2 class="mt30 mb30"><xsl:value-of select="./model"/></h2>
<section class="mt30 full-good-card">
<div class="ib first-column">
<!-- Вывод фото -->
    <xsl:apply-templates select="./photos" />
	<xsl:apply-templates select="./description" />

<a href="../../" class="btn small-btn ib mt30"><img src="/templates/avm.ru/images/white-back.gif" alt="" />
							Вернуться в категорию
						</a>
</div>
<div class="ib second-column ml30">
<div class="ib characteristic">
<p class="mb10"><b class="ib mr10">Марка</b><span class="ib"><xsl:value-of select="./mark"/></span></p>
<p class="mb10"><b class="ib mr10">Год выпуска</b><span class="ib"><xsl:value-of select="./year"/></span></p>
<p class="mb10"><b class="ib mr10">Привод</b><span class="ib"><xsl:value-of select="./drive/type"/></span></p>
<p class="mb10"><b class="ib mr10">Кузов</b><span class="ib"><xsl:value-of select="./body/type"/></span></p>
<p class="mb10"><b class="ib mr10">Пробег, км</b><span class="ib"><xsl:value-of select="./mileage/value"/></span></p>
<p class="mb10"><b class="ib mr10">Двигатель</b><span class="ib"><xsl:value-of select="./engine/type" /></span></p>
<p class="mb10"><b class="ib mr10">Руль</b><span class="ib"><xsl:value-of select="./steering_wheel/place"/></span></p>
<p class="mb10"><b class="ib mr10">Объем двигателя, см³</b><span class="ib"><xsl:value-of select="./engine/volume " /></span></p>
<p class="mb10"><b class="ib mr10">КПП</b><span class="ib"><xsl:value-of select="./gearbox/type"/></span></p>
</div>
<p class="price mt30">Цена: <xsl:choose>
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
<p class="mb10"><b class="ib mr10">Наличие на складе</b><span class="ib"><xsl:value-of select="./availability"/></span></p>
<div class="right_content"><h3>Комплектация</h3>
<ul class="complectation">
</ul>
<ul>
<xsl:call-template name="option">
        <xsl:with-param name="label" select="'Антиблокировочная система (АБС)'"/>
        <xsl:with-param name="element" select="./abs"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Антипробуксовочная система'"/>
        <xsl:with-param name="element" select="./asr"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Система курсовой стабилизации'"/>
        <xsl:with-param name="element" select="./esp"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Парктроник'"/>
        <xsl:with-param name="element" select="./parktronic"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Подушки безопасности: '"/>
        <xsl:with-param name="element" select="./airbag"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Охранная система'"/>
        <xsl:with-param name="element" select="./alarm_system"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Центральный замок'"/>
        <xsl:with-param name="element" select="./central_lock"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Навигационная система'"/>
        <xsl:with-param name="element" select="./nav_system"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Легкосплавные диски'"/>
        <xsl:with-param name="element" select="./light_alloy_wheels"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Датчик дождя'"/>
        <xsl:with-param name="element" select="./sensors/rain"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Датчик света'"/>
        <xsl:with-param name="element" select="./sensors/light"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Омыватель фар'"/>
        <xsl:with-param name="element" select="./headlights/washer"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Ксеноновые фары'"/>
        <xsl:with-param name="element" select="./headlights/xenon"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Салон: '"/>
        <xsl:with-param name="element" select="./compartment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Тонированные стекла'"/>
        <xsl:with-param name="element" select="./windows/tinted"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Люк'"/>
        <xsl:with-param name="element" select="./hatch"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Газобалонное оборудование'"/>
        <xsl:with-param name="element" select="./engine/gas_equipment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Круиз-контроль'"/>
        <xsl:with-param name="element" select="./cruise_control"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Бортовой компьютер'"/>
        <xsl:with-param name="element" select="./trip_computer"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Усилитель рулевого управления: '"/>
        <xsl:with-param name="element" select="./steering_wheel/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Регулировка руля: '"/>
        <xsl:with-param name="element" select="./steering_wheel/adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев руля'"/>
        <xsl:with-param name="element" select="./steering_wheel/heater"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электрозеркала'"/>
        <xsl:with-param name="element" select="./mirrors/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев зеркал'"/>
        <xsl:with-param name="element" select="./mirrors/defroster"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электростеклоподъемники: '"/>
        <xsl:with-param name="element" select="./windows/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев сидений'"/>
        <xsl:with-param name="element" select="./seats/heater"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Регулировка сиденья водителя: '"/>
        <xsl:with-param name="element" select="./seats/driver_adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электропривод сиденья пассажира'"/>
        <xsl:with-param name="element" select="./seats/passanger_adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Управление климатом: '"/>
        <xsl:with-param name="element" select="./climate_control"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Стереосистема: '"/>
        <xsl:with-param name="element" select="./audio"/>
      </xsl:call-template>
</ul>
<h3>Контактная информация</h3>
<p class="contact"><strong>Место осмотра:</strong><br /><xsl:value-of select="./inspection_place"/></p>
<p class="contact"><strong>Телефоны:</strong><br /><xsl:for-each select="./contact/phone">
          <xsl:if test="position() > 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each></p></div>
</div></section>
</div>
  </xsl:template>

  <xsl:template name="car_main">
  
  
  
  
    <div class="car_main">
      <h3>Основные характеристики</h3>
      <div class="span-8">
        <div class="span-3">Год выпуска:</div>
        <xsl:value-of select="./year"/>
      </div>
      <div class="span-8">
        <div class="span-2">Кузов:</div>
        <xsl:value-of select="./body/type"/>
      </div>
      <div class="span-8">
        <div class="span-3">Двигатель:</div>
        <xsl:value-of select="./engine/type" />
        <xsl:text>, </xsl:text>
        <xsl:value-of select="./engine/volume " />
        <xsl:text> см3</xsl:text>
      </div>
      <div class="span-8">
        <div class="span-2">Руль:</div>
        <xsl:value-of select="./steering_wheel/place"/>
      </div>
      <div class="span-8">
        <div class="span-3">Привод:</div>
        <xsl:value-of select="./drive/type"/>
      </div>
      <div class="span-8">
        <div class="span-2">Пробег:</div>
        <xsl:value-of select="./mileage/value"/>
        <xsl:choose>
          <xsl:when test="./mileage/value/@unit = 'km'">
            <xsl:text> км.</xsl:text>
          </xsl:when>
          <xsl:when test="./mileage/value/@unit = 'mile'">
            <xsl:text> миль</xsl:text>
          </xsl:when>
        </xsl:choose>
      </div>
      <div class="span-8">
        <div class="span-3">КПП:</div>
        <xsl:value-of select="./gearbox/type"/>
      </div>
      <div class="span-8">
        <div class="span-2">Состояние:</div>
        <xsl:value-of select="./condition"/>
      </div>
      <div class="span-8">
        <div class="span-3">Цена:</div>
        <xsl:choose>
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
        </xsl:choose>
      </div>
    </div>
    <div class="clear"></div>
  </xsl:template>

  <xsl:template name="car_options">
    <div class="car_options">
      <h3>Комплектация</h3>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Антиблокировочная система (АБС)'"/>
        <xsl:with-param name="element" select="./abs"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Антипробуксовочная система'"/>
        <xsl:with-param name="element" select="./asr"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Система курсовой стабилизации'"/>
        <xsl:with-param name="element" select="./esp"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Парктроник'"/>
        <xsl:with-param name="element" select="./parktronic"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Подушки безопасности: '"/>
        <xsl:with-param name="element" select="./airbag"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Охранная система'"/>
        <xsl:with-param name="element" select="./alarm_system"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Центральный замок'"/>
        <xsl:with-param name="element" select="./central_lock"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Навигационная система'"/>
        <xsl:with-param name="element" select="./nav_system"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Легкосплавные диски'"/>
        <xsl:with-param name="element" select="./light_alloy_wheels"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Датчик дождя'"/>
        <xsl:with-param name="element" select="./sensors/rain"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Датчик света'"/>
        <xsl:with-param name="element" select="./sensors/light"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Омыватель фар'"/>
        <xsl:with-param name="element" select="./headlights/washer"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Ксеноновые фары'"/>
        <xsl:with-param name="element" select="./headlights/xenon"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Салон: '"/>
        <xsl:with-param name="element" select="./compartment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Тонированные стекла'"/>
        <xsl:with-param name="element" select="./windows/tinted"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Люк'"/>
        <xsl:with-param name="element" select="./hatch"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Газобалонное оборудование'"/>
        <xsl:with-param name="element" select="./engine/gas_equipment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Круиз-контроль'"/>
        <xsl:with-param name="element" select="./cruise_control"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Бортовой компьютер'"/>
        <xsl:with-param name="element" select="./trip_computer"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Усилитель рулевого управления: '"/>
        <xsl:with-param name="element" select="./steering_wheel/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Регулировка руля: '"/>
        <xsl:with-param name="element" select="./steering_wheel/adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев руля'"/>
        <xsl:with-param name="element" select="./steering_wheel/heater"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электрозеркала'"/>
        <xsl:with-param name="element" select="./mirrors/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев зеркал'"/>
        <xsl:with-param name="element" select="./mirrors/defroster"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электростеклоподъемники: '"/>
        <xsl:with-param name="element" select="./windows/power"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Обогрев сидений'"/>
        <xsl:with-param name="element" select="./seats/heater"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Регулировка сиденья водителя: '"/>
        <xsl:with-param name="element" select="./seats/driver_adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Электропривод сиденья пассажира'"/>
        <xsl:with-param name="element" select="./seats/passanger_adjustment"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Управление климатом: '"/>
        <xsl:with-param name="element" select="./climate_control"/>
      </xsl:call-template>
      <xsl:call-template name="option">
        <xsl:with-param name="label" select="'Стереосистема: '"/>
        <xsl:with-param name="element" select="./audio"/>
      </xsl:call-template>
    </div>
    <div class="clear"></div>
  </xsl:template>

  <xsl:template name="option">
    <xsl:param name="label"/>
    <xsl:param name="element"/>
    <xsl:if test="$element">
      <div class="span-8">
        <span>
          <xsl:value-of select="$label" />
        </span>
        <xsl:apply-templates select="$element" />
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="photos">
    <div class="photos">
      <h3>Фотографии</h3>
      <a name="photos"></a>
      <div id="original">
	  <xsl:variable name="GETIMG" select="document(concat('udata://auto/getpic/',./photo[position() = 1]/@file_name, '/',/response/vehicle/@dealer_id,'/',/response/vehicle/@vehicle_id))/udata/value" />
	  <xsl:variable name="CFGPG" select="document(concat('udata://system/makeThumbnailFull/(./',$GETIMG,')/373/266/notemplate/0/1'))/udata/src" />
        <a href="{$GETIMG}" class="gallery" rel="prettyPhoto[group]"><img src="{$CFGPG}" width="373" height="266"/></a>
      </div>
	  
      <div id="thumbnails">
        <xsl:apply-templates select="./photo" />
      </div>
    </div>
    <div class="clear"></div>
  </xsl:template>

  <xsl:template match="photo">
    <a href="{./original}" class="ib mt10 ml3 gallery" rel="prettyPhoto[group]">
<xsl:variable name="GETIMG" select="document(concat('udata://auto/getpic/',./@file_name, '/',/response/vehicle/@dealer_id,'/',/response/vehicle/@vehicle_id))/udata/value" />
	  <xsl:variable name="CFGPG" select="document(concat('udata://system/makeThumbnailFull/(./',$GETIMG,')/373/266/notemplate/0/1'))/udata/src" />
      <img src="{$CFGPG}" width="120" height="90"/>
    </a>
  </xsl:template>

  <xsl:template match="description">
    <div class="left_content"><h3>Дополнительная информация</h3>
	<p><span>
      <xsl:call-template name="break">
        <xsl:with-param name="text" select="."/>
      </xsl:call-template>
	  </span></p>
    </div>
	
  </xsl:template>

  <xsl:template name="break">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,'&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="break">
            <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="car_contact">
      <div id="car_contact">
      <h3>Контакты</h3>
          <xsl:if test="./inspection_place">
        <div> 
          <span>Место осмотра: </span>
          <xsl:value-of select="./inspection_place" disable-output-escaping="yes" />
        </div>
          </xsl:if>
          <div>
              <span>Телефон: </span>
        <xsl:for-each select="./contact/phone">
          <xsl:if test="position() > 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
      </div>
      <xsl:if test="./contact/name">
        <div>
          <span>Менеджер: </span>
          <xsl:value-of select="./contact/name"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

</xsl:stylesheet>

