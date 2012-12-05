<?php
 abstract class umiBaseStream implements iUmiBaseStream {public static $allowTimeMark = true;protected    $position = 0,    $length = 0,    $data = "",    $expire = 0,    $transform = "",    $path, $params = array(),    $isJson = false;protected $scheme;protected static $callLog = array();private  $start_time = false;public function __construct() {$this->start_time = microtime(true);}public function stream_flush() {return true;}public function stream_tell() {return $this->position;}public function stream_eof() {return $this->position >= $this->length;}public function stream_seek($v7a86c157ee9713c34fbd7a1ee40f0c5a, $v02c86cc535151887678873a6d0a3c347) {switch($v02c86cc535151887678873a6d0a3c347) {case SEEK_SET: {if($this->isValidOffset($v7a86c157ee9713c34fbd7a1ee40f0c5a)) {$this->position = $v7a86c157ee9713c34fbd7a1ee40f0c5a;return true;}else {return false;}}case SEEK_CUR: {if($v7a86c157ee9713c34fbd7a1ee40f0c5a >= 0) {$this->position += $v7a86c157ee9713c34fbd7a1ee40f0c5a;return true;}else {return false;}}case SEEK_END: {if($this->isValidOffset($this->position + $v7a86c157ee9713c34fbd7a1ee40f0c5a)) {$this->position = $this->length + $v7a86c157ee9713c34fbd7a1ee40f0c5a;return true;}else {return false;}}default: {return false;}}}public function url_stat() {return Array();}public function stream_stat() {return Array();}public function stream_close() {return true;}public function stream_read($ve2942a04780e223b215eb8b663cf5353) {$result = bytes_substr($this->data, $this->position, $ve2942a04780e223b215eb8b663cf5353);$this->position += $ve2942a04780e223b215eb8b663cf5353;return $result;}public function stream_write($ve62e4d22f2d8630f6e44e2b7c3f70ddc) {$vfa2a5780ee71a3c906f941f11804346a = bytes_strlen($ve62e4d22f2d8630f6e44e2b7c3f70ddc);$v5db949cee806af8b6998a0b53bc78489 = bytes_substr($this->data, 0, $this->position);$ve2ad64473fdb1836ebaa0dc70299e9a8 = bytes_substr($this->data, $this->position + $vfa2a5780ee71a3c906f941f11804346a);$this->data = $v5db949cee806af8b6998a0b53bc78489 . $ve62e4d22f2d8630f6e44e2b7c3f70ddc . $ve2ad64473fdb1836ebaa0dc70299e9a8;$this->position += $ve62e4d22f2d8630f6e44e2b7c3f70ddc;return $vfa2a5780ee71a3c906f941f11804346a;}public function getProtocol() {return $this->scheme . "://";}static public function registerStream($v41323917ef8089432959a3c33269debf) {$v2245023265ae4cf87d02c8b6ba991139 = mainConfiguration::getInstance();$v6a2a431fe8b621037ea949531c28551d = $v2245023265ae4cf87d02c8b6ba991139->includeParam('system.kernel.streams') . "{$v41323917ef8089432959a3c33269debf}/{$v41323917ef8089432959a3c33269debf}Stream.php";if(file_exists($v6a2a431fe8b621037ea949531c28551d)) {require $v6a2a431fe8b621037ea949531c28551d;if(!stream_wrapper_register($v41323917ef8089432959a3c33269debf, "{$v41323917ef8089432959a3c33269debf}Stream")) {throw new coreException("Failed to register stream \"{$v41323917ef8089432959a3c33269debf}\"");}}else {throw new coreException("Can't locate file \"{$v6a2a431fe8b621037ea949531c28551d}\"");}}public static function protectParams($veca07335a33c5aeb5e1bc7c98b4b9d80) {return str_replace("/", "&#2F;", $veca07335a33c5aeb5e1bc7c98b4b9d80);}public static function unprotectParams($veca07335a33c5aeb5e1bc7c98b4b9d80) {return str_replace("&#2F;", "/", $veca07335a33c5aeb5e1bc7c98b4b9d80);}public static function getCalledStreams() {$v058ea00715de566bfe7b13f8e17aaf15 = Array();$v843b9f46c0bf720976d53057a3b40877 = 0;foreach(self::$callLog as $v3cde413efdb2e8ce17b094592df0334e) {list($v572d4e421e5e6b9bc11d815e8a027112, $v07cc694b9b3fc636710fa08b6922c42b) = $v3cde413efdb2e8ce17b094592df0334e;$v843b9f46c0bf720976d53057a3b40877 += $v07cc694b9b3fc636710fa08b6922c42b;$v058ea00715de566bfe7b13f8e17aaf15[] = array(     'attribute:generation-time' => $v07cc694b9b3fc636710fa08b6922c42b,     'node:url'     => $v572d4e421e5e6b9bc11d815e8a027112    );}$vfca1bff8ad8b3a8585abfb0ad523ba42 = array('nodes:call' => $v058ea00715de566bfe7b13f8e17aaf15);$vdd988cfd769c9f7fbd795a0f5da8e751 = new DOMDocument;$vdd988cfd769c9f7fbd795a0f5da8e751->formatOutput = XML_FORMAT_OUTPUT;$v173a1756d2d82394cb803161f70f9a38 = $vdd988cfd769c9f7fbd795a0f5da8e751->createElement("streams-call");$v173a1756d2d82394cb803161f70f9a38->setAttribute('total-time', $v843b9f46c0bf720976d53057a3b40877);$vdd988cfd769c9f7fbd795a0f5da8e751->appendChild($v173a1756d2d82394cb803161f70f9a38);$vea392050444b5a06a86b8ec9c02d2437 = new xmlTranslator($vdd988cfd769c9f7fbd795a0f5da8e751);$vea392050444b5a06a86b8ec9c02d2437->translateToXml($v173a1756d2d82394cb803161f70f9a38, $vfca1bff8ad8b3a8585abfb0ad523ba42);return $vdd988cfd769c9f7fbd795a0f5da8e751->saveXml();}public static function reportCallTime($vd6fe1d0be6347b8ef2427fa629c04485, $v07cc694b9b3fc636710fa08b6922c42b) {foreach(self::$callLog as &$v3cde413efdb2e8ce17b094592df0334e) {$v63aaa382d493096040036f07fdbd9d22 = explode("?", $v3cde413efdb2e8ce17b094592df0334e[0]);if($v63aaa382d493096040036f07fdbd9d22[0] == $vd6fe1d0be6347b8ef2427fa629c04485) {$v3cde413efdb2e8ce17b094592df0334e[1] = $v07cc694b9b3fc636710fa08b6922c42b;}}}protected function isValidOffset($v7a86c157ee9713c34fbd7a1ee40f0c5a) {return ($v7a86c157ee9713c34fbd7a1ee40f0c5a >= 0) && ($v7a86c157ee9713c34fbd7a1ee40f0c5a < $this->length);}protected function translateToXml() {$args = func_get_args();$v9b207167e5381c47682c6b4f58a623fb = $args[0];if($this->isJson) {return $this->translateToJSON($v9b207167e5381c47682c6b4f58a623fb);}if(isset($v9b207167e5381c47682c6b4f58a623fb['plain:result'])) {return $v9b207167e5381c47682c6b4f58a623fb['plain:result'];}$vdd988cfd769c9f7fbd795a0f5da8e751 = new DOMDocument("1.0", "utf-8");$vdd988cfd769c9f7fbd795a0f5da8e751->formatOutput = XML_FORMAT_OUTPUT;$v173a1756d2d82394cb803161f70f9a38 = $vdd988cfd769c9f7fbd795a0f5da8e751->createElement("udata");$vdd988cfd769c9f7fbd795a0f5da8e751->appendChild($v173a1756d2d82394cb803161f70f9a38);$v173a1756d2d82394cb803161f70f9a38->setAttribute('xmlns:xlink', 'http://www.w3.org/TR/xlink');$va9af713c2b2cfe00ff6c77a6a07127ed = new xmlTranslator($vdd988cfd769c9f7fbd795a0f5da8e751);$va9af713c2b2cfe00ff6c77a6a07127ed->translateToXml($v173a1756d2d82394cb803161f70f9a38, $v9b207167e5381c47682c6b4f58a623fb);$vf9d06f6bf4fdf64ee0d73708c1a94ee1 = number_format(microtime(true) - $this->start_time, 6);$v173a1756d2d82394cb803161f70f9a38->setAttribute('generation-time', $vf9d06f6bf4fdf64ee0d73708c1a94ee1);self::reportCallTime($this->getProtocol() . $this->path, $vf9d06f6bf4fdf64ee0d73708c1a94ee1);if($this->transform) {return $this->applyXslTransformation($vdd988cfd769c9f7fbd795a0f5da8e751, $this->transform);}return $vdd988cfd769c9f7fbd795a0f5da8e751->saveXml();}protected function applyXslTransformation(DOMDocument $vdd988cfd769c9f7fbd795a0f5da8e751, $v6a559eac8ab38b0b76a6fca32dcb9749) {$v2245023265ae4cf87d02c8b6ba991139 = mainConfiguration::getInstance();if ($v6829cdfdefd69b947abedd8fa2c4bcc7 = cmsController::getInstance()->getResourcesDirectory()) {$vf2ce473b36fb79a44028293890c685be = $v6829cdfdefd69b947abedd8fa2c4bcc7 . "/xslt/";}else {$vf2ce473b36fb79a44028293890c685be = $v2245023265ae4cf87d02c8b6ba991139->includeParam('templates.xsl');}$v47826cacc65c665212b821e6ff80b9b0 = $vf2ce473b36fb79a44028293890c685be . $v6a559eac8ab38b0b76a6fca32dcb9749;if(is_file($v47826cacc65c665212b821e6ff80b9b0) == false) {throw new publicException("Udata trasform xsl-template was not found \"{$v47826cacc65c665212b821e6ff80b9b0}\"");}$vc3aaa7dd2c4cf0305f95e82438b46e82 = DomDocument::load($v47826cacc65c665212b821e6ff80b9b0, DOM_LOAD_OPTIONS);checkXmlError($vc3aaa7dd2c4cf0305f95e82438b46e82);$v801f7201346b43f8ee8390a1ef20ddcd = new xsltProcessor;$v801f7201346b43f8ee8390a1ef20ddcd->registerPHPFunctions();$v801f7201346b43f8ee8390a1ef20ddcd->importStyleSheet($vc3aaa7dd2c4cf0305f95e82438b46e82);return $v801f7201346b43f8ee8390a1ef20ddcd->transformToXML($vdd988cfd769c9f7fbd795a0f5da8e751);}protected function parsePath($vd6fe1d0be6347b8ef2427fa629c04485) {$v81788ba0d7d02d81c063dbca621ba11b = $this->getProtocol();$vd6fe1d0be6347b8ef2427fa629c04485 = substr($vd6fe1d0be6347b8ef2427fa629c04485, strlen($v81788ba0d7d02d81c063dbca621ba11b));$v6d530125c7b0bc91b8b49c9d98795759 = parse_url($vd6fe1d0be6347b8ef2427fa629c04485);$v6d92ba33a14649f2a6f698b128302ad7 = $v6d530125c7b0bc91b8b49c9d98795759['path'];if(substr($v6d92ba33a14649f2a6f698b128302ad7, -5) == '.json') {$v6d92ba33a14649f2a6f698b128302ad7 = substr($v6d92ba33a14649f2a6f698b128302ad7, 0, strlen($v6d92ba33a14649f2a6f698b128302ad7) - 5);$this->isJson = true;}else $this->isJson = false;$this->path = $v6d92ba33a14649f2a6f698b128302ad7;self::$callLog[] = array($v81788ba0d7d02d81c063dbca621ba11b . $vd6fe1d0be6347b8ef2427fa629c04485, false);if($v21ffce5b8a6cc8cc6a41448dd69623c9 = getArrayKey($v6d530125c7b0bc91b8b49c9d98795759, 'query')) {parse_str($v21ffce5b8a6cc8cc6a41448dd69623c9, $vd5330079a488b3cac29a84f13a458629);$this->params = $vd5330079a488b3cac29a84f13a458629;$_REQUEST = array_merge($_REQUEST, $vd5330079a488b3cac29a84f13a458629);if(isset($vd5330079a488b3cac29a84f13a458629['expire'])) {$this->expire = getArrayKey($vd5330079a488b3cac29a84f13a458629, 'expire');}if(isset($vd5330079a488b3cac29a84f13a458629['transform'])) {$this->transform = getArrayKey($vd5330079a488b3cac29a84f13a458629, 'transform');}}if(!$this->expire) {$v2245023265ae4cf87d02c8b6ba991139 = mainConfiguration::getInstance();if ($v2245023265ae4cf87d02c8b6ba991139->get('cache', 'streams.cache-enabled')) {$vcd91e7679d575a2c548bd2c889c23b9e = (int) $v2245023265ae4cf87d02c8b6ba991139->get('cache', 'streams.cache-lifetime');if ($vcd91e7679d575a2c548bd2c889c23b9e > 0) {$this->expire = $vcd91e7679d575a2c548bd2c889c23b9e;}}}return $this->path;}protected function normalizeString($v341be97d9aff90c9978347f66f945b77) {$v341be97d9aff90c9978347f66f945b77 = urldecode($v341be97d9aff90c9978347f66f945b77);if(!preg_match("/[\x{0000}-\x{FFFF}]+/u", $v341be97d9aff90c9978347f66f945b77)) {$v341be97d9aff90c9978347f66f945b77 = iconv("CP1251", "UTF-8//IGNORE", $v341be97d9aff90c9978347f66f945b77);}return $v341be97d9aff90c9978347f66f945b77;}protected function setData($v8d777f385d3dfec8815d20f7496026dc) {if(!$v8d777f385d3dfec8815d20f7496026dc) {return false;}$this->data = $v8d777f385d3dfec8815d20f7496026dc;$this->length = bytes_strlen($v8d777f385d3dfec8815d20f7496026dc);return true;}protected function setDataError($v0279985cdca9ad2836b5dc949af215c8) {$v8d777f385d3dfec8815d20f7496026dc = Array(    'error' => Array(     'attribute:code' => $v0279985cdca9ad2836b5dc949af215c8,     'node:message' => getLabel('error-' . $v0279985cdca9ad2836b5dc949af215c8)    )   );$v8d777f385d3dfec8815d20f7496026dc = self::translateToXml($v8d777f385d3dfec8815d20f7496026dc);$this->setData($v8d777f385d3dfec8815d20f7496026dc);return true;}protected function translateToJSON($v8d777f385d3dfec8815d20f7496026dc) {$v607f2f3099f2a347b327caa70e0be4b2 = new jsonTranslator;return $v607f2f3099f2a347b327caa70e0be4b2->translateToJson($v8d777f385d3dfec8815d20f7496026dc);}};?>