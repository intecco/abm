<?php
class umiAuth extends singleton implements iSingleton, iUmiAuth {const PREAUTH_INVALID = 0;const PREAUTH_SUCCESS_NEW = 1;const PREAUTH_SUCCESS_RESTORE = 2;const PREAUTH_ALREADY = 3;const PREAUTH_NEEDNOT = 4;public function __construct() {}public static function getInstance($v4a8a08f09d37b73795649038408b5f33 = NULL) {return parent::getInstance(__CLASS__);}public function tryPreAuth() {$v870fd5468174f846789cb0d56d95bed7 = "";$v61b14997da4f52f41ee7b0d90f09e670 = "";$ve218c54eefdbe103350435489a6595cb = "";$v2b2dccfdbf6e767de8512d66da6d18ca = 'u-login';$vad1ffbcb1d643a30a5f6cc9950526e81 = 'u-password';$ve57492e1c3bb8975edf9399351741cf8 = 'u-password-md5';$v0a7cb1c6ec211bc445c36725ebfb7bab = 'u-session-id';$v50b6116b0f49a6cb34e310d17da0ccc4 = ini_get("session.name");if($v870fd5468174f846789cb0d56d95bed7 = getCookie($v2b2dccfdbf6e767de8512d66da6d18ca)) {if($v61b14997da4f52f41ee7b0d90f09e670 = getCookie($vad1ffbcb1d643a30a5f6cc9950526e81)) {$v61b14997da4f52f41ee7b0d90f09e670 = md5($v61b14997da4f52f41ee7b0d90f09e670);}else {$v61b14997da4f52f41ee7b0d90f09e670 = getCookie($ve57492e1c3bb8975edf9399351741cf8);}}if (function_exists('apache_request_headers')) {$v47722c9511693b9a32d48982e48a7b9b = apache_request_headers();if (isset($v47722c9511693b9a32d48982e48a7b9b[$v2b2dccfdbf6e767de8512d66da6d18ca])) {$v870fd5468174f846789cb0d56d95bed7 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $v47722c9511693b9a32d48982e48a7b9b[$v2b2dccfdbf6e767de8512d66da6d18ca]));}if (isset($v47722c9511693b9a32d48982e48a7b9b[$ve57492e1c3bb8975edf9399351741cf8])) {$v61b14997da4f52f41ee7b0d90f09e670 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $v47722c9511693b9a32d48982e48a7b9b[$ve57492e1c3bb8975edf9399351741cf8]));}elseif (isset($v47722c9511693b9a32d48982e48a7b9b[$vad1ffbcb1d643a30a5f6cc9950526e81])) {$v61b14997da4f52f41ee7b0d90f09e670 = md5(umiObjectProperty::filterInputString(str_replace(chr(0), "", $v47722c9511693b9a32d48982e48a7b9b[$vad1ffbcb1d643a30a5f6cc9950526e81])));}if (isset($v47722c9511693b9a32d48982e48a7b9b[$v0a7cb1c6ec211bc445c36725ebfb7bab])) {$ve218c54eefdbe103350435489a6595cb = umiObjectProperty::filterInputString(str_replace(chr(0), "", $v47722c9511693b9a32d48982e48a7b9b[$v0a7cb1c6ec211bc445c36725ebfb7bab]));}}if (isset($_POST[$v2b2dccfdbf6e767de8512d66da6d18ca])) {$v870fd5468174f846789cb0d56d95bed7 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_POST[$v2b2dccfdbf6e767de8512d66da6d18ca]));}if (isset($_POST[$ve57492e1c3bb8975edf9399351741cf8])) {$v61b14997da4f52f41ee7b0d90f09e670 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_POST[$ve57492e1c3bb8975edf9399351741cf8]));}elseif (isset($_POST[$vad1ffbcb1d643a30a5f6cc9950526e81])) {$v61b14997da4f52f41ee7b0d90f09e670 = md5(umiObjectProperty::filterInputString(str_replace(chr(0), "", $_POST[$vad1ffbcb1d643a30a5f6cc9950526e81])));}if (isset($_POST[$v0a7cb1c6ec211bc445c36725ebfb7bab])) {$ve218c54eefdbe103350435489a6595cb = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_POST[$v0a7cb1c6ec211bc445c36725ebfb7bab]));}if (isset($_GET[$v2b2dccfdbf6e767de8512d66da6d18ca])) {$v870fd5468174f846789cb0d56d95bed7 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_GET[$v2b2dccfdbf6e767de8512d66da6d18ca]));}if (isset($_GET[$ve57492e1c3bb8975edf9399351741cf8])) {$v61b14997da4f52f41ee7b0d90f09e670 = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_GET[$ve57492e1c3bb8975edf9399351741cf8]));}elseif (isset($_GET[$vad1ffbcb1d643a30a5f6cc9950526e81])) {$v61b14997da4f52f41ee7b0d90f09e670 = md5(umiObjectProperty::filterInputString(str_replace(chr(0), "", $_GET[$vad1ffbcb1d643a30a5f6cc9950526e81])));}if (isset($_GET[$v0a7cb1c6ec211bc445c36725ebfb7bab])) {$ve218c54eefdbe103350435489a6595cb = umiObjectProperty::filterInputString(str_replace(chr(0), "", $_GET[$v0a7cb1c6ec211bc445c36725ebfb7bab]));}if (strlen($v870fd5468174f846789cb0d56d95bed7) && strlen($v61b14997da4f52f41ee7b0d90f09e670)) {$vf5b788937450a693e6cbec05d8b8b13f = umiObjectTypesCollection::getInstance()->getBaseType("users", "user");$v8636cb7e3d45cd4e1e8e863d3286393e = umiObjectTypesCollection::getInstance()->getType($vf5b788937450a693e6cbec05d8b8b13f);$v8f671407d6df210b2670166a82e0fc1a = $v8636cb7e3d45cd4e1e8e863d3286393e->getFieldId("login");$v98fc9fb0068cf0cdca3ce2e0cb0843d6 = $v8636cb7e3d45cd4e1e8e863d3286393e->getFieldId("password");$v713d1619aba4eeb6679aec2b499e1b33 = $v8636cb7e3d45cd4e1e8e863d3286393e->getFieldId("is_activated");$v8be74552df93e31bbdd6b36ed74bdb6a = new umiSelection;$v8be74552df93e31bbdd6b36ed74bdb6a->setLimitFilter();$v8be74552df93e31bbdd6b36ed74bdb6a->addLimit(1);$v8be74552df93e31bbdd6b36ed74bdb6a->setObjectTypeFilter();$v8be74552df93e31bbdd6b36ed74bdb6a->addObjectType($vf5b788937450a693e6cbec05d8b8b13f);$v8be74552df93e31bbdd6b36ed74bdb6a->setPropertyFilter();$v8be74552df93e31bbdd6b36ed74bdb6a->addPropertyFilterEqual($v8f671407d6df210b2670166a82e0fc1a, $v870fd5468174f846789cb0d56d95bed7);$v8be74552df93e31bbdd6b36ed74bdb6a->addPropertyFilterEqual($v98fc9fb0068cf0cdca3ce2e0cb0843d6, $v61b14997da4f52f41ee7b0d90f09e670);$v8be74552df93e31bbdd6b36ed74bdb6a->addPropertyFilterEqual($v713d1619aba4eeb6679aec2b499e1b33, 1);$result = umiSelectionsParser::runSelection($v8be74552df93e31bbdd6b36ed74bdb6a);if(sizeof($result) === 1) {$vbc8a7343779d62b3f0dc86f78848bde1 = intval($result[0]);if (!session_id())    {session_start();}$vc87c62534434262e1d1c1348215684ef = session_id();system_runSession();if (strlen($vc87c62534434262e1d1c1348215684ef) && isset($_SESSION) && isset($_SESSION['cms_login']) && isset($_SESSION['cms_pass']) && isset($_SESSION['user_id']) && $_SESSION['cms_login'] === $v870fd5468174f846789cb0d56d95bed7 && $_SESSION['cms_pass'] === $v61b14997da4f52f41ee7b0d90f09e670 && $_SESSION['user_id'] === $vbc8a7343779d62b3f0dc86f78848bde1) {$_SESSION['starttime']=time();return self::PREAUTH_ALREADY;}if (strlen($ve218c54eefdbe103350435489a6595cb)) {if (strlen($vc87c62534434262e1d1c1348215684ef)) {session_destroy();}session_id($ve218c54eefdbe103350435489a6595cb);session_start();$_SESSION['starttime']=time();if (!(isset($_SESSION['cms_login']) && isset($_SESSION['cms_pass']) && isset($_SESSION['user_id']) && $_SESSION['cms_login'] === $v870fd5468174f846789cb0d56d95bed7 && $_SESSION['cms_pass'] === $v61b14997da4f52f41ee7b0d90f09e670 && $_SESSION['user_id'] === $vbc8a7343779d62b3f0dc86f78848bde1)) {session_destroy();}else {$vd69634a59b2cc5df7d632e48474afc94 = new umiEventPoint("users_prelogin_successfull");$vd69634a59b2cc5df7d632e48474afc94->setParam("prelogin_mode", self::PREAUTH_SUCCESS_RESTORE);$vd69634a59b2cc5df7d632e48474afc94->setParam("user_id", $vbc8a7343779d62b3f0dc86f78848bde1);umiEventsController::getInstance()->callEvent($vd69634a59b2cc5df7d632e48474afc94);return self::PREAUTH_SUCCESS_RESTORE;}}else {@session_start();$_SESSION['cms_login'] = $v870fd5468174f846789cb0d56d95bed7;$_SESSION['cms_pass'] = $v61b14997da4f52f41ee7b0d90f09e670;$_SESSION['user_id'] = $vbc8a7343779d62b3f0dc86f78848bde1;$v41275a535677f79ff347e01bc530c176 = permissionsCollection::getInstance();if($v41275a535677f79ff347e01bc530c176->isSv($vbc8a7343779d62b3f0dc86f78848bde1)) {$_SESSION['user_is_sv'] = true;}session_commit();session_start();$_SESSION['starttime']=time();$vd69634a59b2cc5df7d632e48474afc94 = new umiEventPoint("users_prelogin_successfull");$vd69634a59b2cc5df7d632e48474afc94->setParam("prelogin_mode", self::PREAUTH_SUCCESS_NEW);$vd69634a59b2cc5df7d632e48474afc94->setParam("user_id", $vbc8a7343779d62b3f0dc86f78848bde1);umiEventsController::getInstance()->callEvent($vd69634a59b2cc5df7d632e48474afc94);if (isset($_REQUEST['u-login-store']) && (intval($_REQUEST['u-login-store']) || strtoupper($_REQUEST['u-login-store']) === 'ON')) {setcookie($v2b2dccfdbf6e767de8512d66da6d18ca, $v870fd5468174f846789cb0d56d95bed7, (time() + (60 * 60 * 24 * 31)), "/");setcookie($ve57492e1c3bb8975edf9399351741cf8, $v61b14997da4f52f41ee7b0d90f09e670, (time() + (60 * 60 * 24 * 31)), "/");}return self::PREAUTH_SUCCESS_NEW;}}}return self::PREAUTH_INVALID;}}?>