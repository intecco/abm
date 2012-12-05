<?php

$INFO = Array();

$INFO['version'] = "2.0.0.0";
$INFO['version_line'] = "lite";

$INFO['name'] = "auto";
$INFO['title'] = "Каталог авто";
$INFO['filename'] = "modules/auto/class.php";
$INFO['config'] = "1";
$INFO['ico'] = "ico_catalog";
$INFO['default_method'] = "category";
$INFO['default_method_admin'] = "tree";
$INFO['is_indexed'] = "0";
$INFO['per_page'] = 10;


$INFO['func_perms'] = "";

$INFO['func_perms/tree'] = "Управление каталогом";


$INFO['func_perms/view'] = "Просмотр каталога";

$INFO['func_perms/view/category'] = "";


$SQL_INSTALL = Array();

$COMPONENTS = array();

$COMPONENTS[0] = "./classes/modules/auto/__admin.php";
$COMPONENTS[1] = "./classes/modules/auto/__custom.php";
$COMPONENTS[2] = "./classes/modules/auto/__custom_adm.php";
$COMPONENTS[3] = "./classes/modules/auto/__search.php";
$COMPONENTS[4] = "./classes/modules/auto/class.php";
$COMPONENTS[5] = "./classes/modules/auto/i18n.en.php";
$COMPONENTS[6] = "./classes/modules/auto/i18n.php";
$COMPONENTS[7] = "./classes/modules/auto/lang.php";
$COMPONENTS[8] = "./classes/modules/auto/permissions.php";



?>