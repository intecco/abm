<?php
 class umiDistrFile extends umiDistrInstallItem {protected $filePath, $permissions, $content;public function __construct($v47826cacc65c665212b821e6ff80b9b0 = false) {if($v47826cacc65c665212b821e6ff80b9b0 !== false) {$this->filePath = $v47826cacc65c665212b821e6ff80b9b0;$this->permissions = fileperms($v47826cacc65c665212b821e6ff80b9b0) & 0x1FF;$this->content = file_get_contents($v47826cacc65c665212b821e6ff80b9b0);}}public function pack() {return base64_encode(serialize($this));}public static function unpack($v8d777f385d3dfec8815d20f7496026dc) {return base64_decode(unserialize($v8d777f385d3dfec8815d20f7496026dc));}public function restore() {if(is_file($this->filePath)) {if(is_writable($this->filePath)) {@file_put_contents($this->filePath, $this->content);}else {return false;}return true;}else {$v4b3a6218bb3e3a7303e8a171a60fcf92 = @file_put_contents($this->filePath, $this->content);if(strlen($this->content)) {return (bool) $v4b3a6218bb3e3a7303e8a171a60fcf92;}else {return true;}}}};?>