<?php
 class language_morph implements iLanguageMorph {private $lang;public function __construct() {}public static function get_word_base($vc47d187067c6cf953245f128b5fde62a) {$vce5f02f301018ab60c4921d6654a75cd = umiConversion::getInstance();return $vce5f02f301018ab60c4921d6654a75cd->stemmerRu($vc47d187067c6cf953245f128b5fde62a);}public static function get_word_morph($vc47d187067c6cf953245f128b5fde62a, $v599dcce2998a6b40b1e38e8c6006cb0a = 'noun', $ve2942a04780e223b215eb8b663cf5353 = 0) {}};?>