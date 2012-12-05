<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:template match="/" mode="layout">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>

		<html>

			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta name="keywords" content="{//meta/keywords}" />
				<meta name="description" content="{//meta/description}" />
				<meta name="author" content="" />
				<meta name="viewport" content="width=1024" />

				<title>
					<xsl:value-of select="$document-title" />
				</title>

				<!--### START stylesheet -->
				<link rel="stylesheet" href="{$template-resources}css/main.css" />
				<link rel="stylesheet" href="{$template-resources}css/custom.css" />
				<link rel="stylesheet" type="text/css" href="{$template-resources}js/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
				<link rel="stylesheet" href="{$template-resources}css/prettyPhoto.css" />
				<!--### END stylesheet -->

				<!--### START javascripts -->
				<xsl:if test="$user-type='sv'">
					<xsl:value-of select="document('udata://system/includeQuickEditJs')/udata" disable-output-escaping="yes" />
				</xsl:if>

				<xsl:if test="$user-type!='sv'">
					<script type="text/javascript" src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
				</xsl:if>
				
				<script type="text/javascript" src="{$template-resources}js/prettyPhoto/jquery.prettyPhoto.js"></script>
				<script type="text/javascript" src="{$template-resources}js/default_value.js"></script>
				<script type="text/javascript" src="{$template-resources}js/script.js"></script>
				<script type="text/javascript" src="{$template-resources}js/custom.js"></script>
				<script type="text/javascript" src="{$template-resources}js/jquery.validate.js"></script>
				<script type="text/javascript" src="{$template-resources}js/validation.js"></script>
				<script charset="utf-8" src="/js/site/__common.js?{/result/@system-build}" type="text/javascript"></script>
				<script type="text/javascript" src="{$template-resources}js/cusel-min.js"></script>
				<script type="text/javascript" src="{$template-resources}js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
				<script src="https://maps-api-ssl.google.com/maps/api/js?v=3&amp;sensor=true" type="text/javascript"></script>
				<script type="text/javascript" src="{$template-resources}js/google-map.js"></script>

				<xsl:if test="$module='faq'">
					<script type="text/javascript" src="{$template-resources}js/faq.js"></script>
				</xsl:if>
				

				<!--### END javascripts -->

				<xsl:text disable-output-escaping="yes">&lt;!--[if IE]&gt; &lt;script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"&gt; &lt;/script&gt; &lt;style type="text/css"&gt; .clear { zoom: 1; display: block; } &lt;/style&gt; &lt;link rel="stylesheet" href="/templates/avm.ru/css/ie.css" /&gt; &lt;![endif]--&gt;</xsl:text>
				<xsl:text disable-output-escaping="yes">&lt;!--[if IE 7]&gt; &lt;link rel="stylesheet" href="/templates/avm.ru/css/ie7.css" /&gt; &lt;![endif]--&gt;</xsl:text>
				<xsl:text disable-output-escaping="yes">&lt;!--[if IE 8]&gt; &lt;link rel="stylesheet" href="/templates/avm.ru/css/ie8.css" /&gt; &lt;![endif]--&gt;</xsl:text>
				<xsl:text disable-output-escaping="yes">&lt;!--[if IE 9]&gt; &lt;link rel="stylesheet" href="/templates/avm.ru/css/ie9.css" /&gt; &lt;![endif]--&gt;</xsl:text>
			</head>
			<body>
				<!-- webim button generation date: 2012-08-02 version: 6.9.2 -->
				<a class="webim_button" href="" rel="webim"><img src="http://abmcentreru.pro-service.webim.ru/webim/button.php" border="0"/></a>

				<script type="text/javascript">
				  webim = {
					accountName: "abmcentreru",
					domain: "abmcentreru.pro-service.webim.ru"
				  };
				  (function () {
					  var s = document.createElement("script");
					  s.type = "text/javascript";
					  s.src = "http://abmcentreru.pro-service.webim.ru/webim/js/button.js";
					  document.getElementsByTagName("head")[0].appendChild(s);
				  })();
				</script>
				<!-- /webim button -->

				<div id="page">
					<!-- content/menu.xsl -->
					<xsl:call-template name="classChoose" />
					
					<div class="conteiner">
						<header>
							<a href="/" class="logo fl"></a>
							<ul class="consult-and-cab-widget ib ml55 mt15">
								<li class="ib online-consult-ico">
									<a href="#">
										<xsl:text>Онлайн-консультант</xsl:text>
									</a>
								</li>

								<xsl:apply-templates select="result/user" mode="topLink" />
								<xsl:apply-templates select="document('udata://emarket/cart/')/udata" mode="short" />
							</ul>
							<form action="/search/search_do/" method="get" class="quick-search ib" id="searchForm">
								<input type="text" def="Поиск" class="ib" name="search_string" />
								<input type="hidden" name="search_types" value="49" />
								<a href="#" class="qssubmit ib linkSubmit" rel="searchForm"></a>
							</form>



							<xsl:apply-templates select="document('udata://content/menu/')/udata" mode="top_menu" />
						</header>


						<div id="main">

							<!-- Left column -->
							<aside class="ib">

								<!-- content/menu.xsl -->
								<xsl:call-template name="leftMenu" />

								<!-- content/menu.xsl -->
								<xsl:call-template name="leftBottomMenu" />

							</aside>

							<!-- Right column -->
							<div class="content ib">
								<!-- content/menu.xsl -->
								<xsl:call-template name="breadcrumbs" />
								<xsl:apply-templates select="/result" />
							</div>

						</div>
						<div class="empty"></div>
					</div>

					<footer>
						<!-- content/footer.xsl -->
						<xsl:call-template name="footerContent" />
					</footer>

				</div>
				<xsl:if test="$user-type='guest'">
					<div class="simple_overlay" id="login-form">
						<form action="/users/login_do/" id="overlayForm">
							<div>
								<span>E-mail</span>
								<input type="text" name="login" class="ib" />
							</div>
							<div class="mt10">
								<span>Пароль</span>
								<input type="password" name="password" class="ib" />
							</div>
							<div class="ib mt10">
								<a href="/registrate">Зарегистрироваться</a>
								<br />
								<a href="/forget">Напомнить пароль</a>
							</div>

							<a href="#" class="btn2 ib mt10 ml13 linkSubmit" rel="overlayForm"></a>
						</form>
					</div>
				</xsl:if>
			</body>

		</html>
	</xsl:template>

</xsl:stylesheet>