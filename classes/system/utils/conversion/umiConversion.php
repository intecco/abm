<?php
class umiConversion {private static $m_oInstance = null;private $m_aProcedures = array();private function __construct() {}public function __destruct() {}public static function getInstance() {if(self::$m_oInstance == null) {self::$m_oInstance = new umiConversion();}return self::$m_oInstance;}public function __call($_sMethodName, $_aMethodArguments) {if(!isset($this->m_aProcedures[$_sMethodName])) {$vaef4af7c9418e25ce18477ef1a73086d   = $_sMethodName;$vbf7be97451be760d000d8fd7b26c5a3d = dirname(__FILE__) . '/procedures/' . $vaef4af7c9418e25ce18477ef1a73086d . '.conversion.php';if(!file_exists($vbf7be97451be760d000d8fd7b26c5a3d)) return (count($_aMethodArguments) == 1) ? $_aMethodArguments[0] : $_aMethodArguments ;include($vbf7be97451be760d000d8fd7b26c5a3d);$v7e9e026cc70a2f6bf79551a11b60a2ce  = new $vaef4af7c9418e25ce18477ef1a73086d();$this->m_aProcedures[$_sMethodName] = $v7e9e026cc70a2f6bf79551a11b60a2ce;}$v7e9e026cc70a2f6bf79551a11b60a2ce = $this->m_aProcedures[$_sMethodName];if($v7e9e026cc70a2f6bf79551a11b60a2ce instanceof IGenericConversion)            return $v7e9e026cc70a2f6bf79551a11b60a2ce->convert($_aMethodArguments);else            return (count($_aMethodArguments) == 1) ? $_aMethodArguments[0] : $_aMethodArguments ;}}?>