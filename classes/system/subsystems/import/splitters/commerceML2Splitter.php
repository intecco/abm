<?php
 class commerceML2Splitter extends umiImportSplitter {public $ignoreParentGroups = false;public $autoGuideCreation = true;public $renameFiles = true;protected function __getNodeParents(DOMNode $v8e2dcfd7e7e24b1ca76c1193f645902b) {$vc68ad910ed49ac65f21f1bf2c5dbf912 = array();$vc68ad910ed49ac65f21f1bf2c5dbf912[] = $v8e2dcfd7e7e24b1ca76c1193f645902b->nodeName;if (($vd0e45878043844ffc41aac437e86b602 = $v8e2dcfd7e7e24b1ca76c1193f645902b->parentNode) instanceof DOMElement) {$vc68ad910ed49ac65f21f1bf2c5dbf912 = array_merge($this->__getNodeParents($v8e2dcfd7e7e24b1ca76c1193f645902b->parentNode), $vc68ad910ed49ac65f21f1bf2c5dbf912);}return $vc68ad910ed49ac65f21f1bf2c5dbf912;}protected function __getNodePath(DOMNode $v8e2dcfd7e7e24b1ca76c1193f645902b) {return implode("/", $this->__getNodeParents($v8e2dcfd7e7e24b1ca76c1193f645902b));}protected function __collectGroup(DOMDocument $v9a09b4dfda82e3e665e31092d1c3ec8d, DOMNode $v1471e4e05a4db95d353cc867fe317314, DOMNode $vdb0f6f37ebeb6ea09489124345af2a45) {$v3d788fa62d7c185a1bee4c9147ee1091 = new DOMXPath($v9a09b4dfda82e3e665e31092d1c3ec8d);$vb8d7f0a7b1f89a0e2689069b9ead837d = $vdb0f6f37ebeb6ea09489124345af2a45->getElementsByTagName("Ид");$v00655e48bd78b9fefe2ba39b753dd932 = $vdb0f6f37ebeb6ea09489124345af2a45->getElementsByTagName("Наименование");$vb80bb7740288fda1f201890375a60c8f = $vb8d7f0a7b1f89a0e2689069b9ead837d->item(0)->nodeValue;$vb068931cc450442b63f5b3d276ea4297 = $v00655e48bd78b9fefe2ba39b753dd932->item(0)->nodeValue;$vc772070e479ef7642e1f6b1620b703ab = $v3d788fa62d7c185a1bee4c9147ee1091->evaluate(".//Группа[Ид='{$vb80bb7740288fda1f201890375a60c8f}']", $v1471e4e05a4db95d353cc867fe317314);if ($vc772070e479ef7642e1f6b1620b703ab instanceof DOMNodeList && $vc772070e479ef7642e1f6b1620b703ab->length) {return $vc772070e479ef7642e1f6b1620b703ab->item(0);}$v1722ade329f7d0765de2a5d5cf04b3e6 = $v9a09b4dfda82e3e665e31092d1c3ec8d->createElement('Группа');$v1722ade329f7d0765de2a5d5cf04b3e6->appendChild($v9a09b4dfda82e3e665e31092d1c3ec8d->createElement('Ид', $vb80bb7740288fda1f201890375a60c8f));$v1722ade329f7d0765de2a5d5cf04b3e6->appendChild($v9a09b4dfda82e3e665e31092d1c3ec8d->createElement('Наименование', $vb068931cc450442b63f5b3d276ea4297));$vd0e45878043844ffc41aac437e86b602 = $vdb0f6f37ebeb6ea09489124345af2a45->parentNode ? $vdb0f6f37ebeb6ea09489124345af2a45->parentNode->parentNode : false;if ($vd0e45878043844ffc41aac437e86b602 && $vd0e45878043844ffc41aac437e86b602->nodeName == "Группа") {$v8040a7de679c140285d7b0ca689dadc5 = $this->__collectGroup($v9a09b4dfda82e3e665e31092d1c3ec8d, $v1471e4e05a4db95d353cc867fe317314, $vd0e45878043844ffc41aac437e86b602);$vecc14ae322be7f2622dee4a101209ee9 = $v8040a7de679c140285d7b0ca689dadc5->childNodes->item(2);if (!$vecc14ae322be7f2622dee4a101209ee9) $vecc14ae322be7f2622dee4a101209ee9 = $v8040a7de679c140285d7b0ca689dadc5->appendChild($v9a09b4dfda82e3e665e31092d1c3ec8d->createElement("Группы"));$vecc14ae322be7f2622dee4a101209ee9->appendChild($v1722ade329f7d0765de2a5d5cf04b3e6);}else {$v1471e4e05a4db95d353cc867fe317314->appendChild($v1722ade329f7d0765de2a5d5cf04b3e6);}return $v1722ade329f7d0765de2a5d5cf04b3e6;}protected function __getOffersCompare(DOMDocument $v9a09b4dfda82e3e665e31092d1c3ec8d, DOMDocument $vd60db28d94d538bbb249dcc7f2273ab1, $v95723b5e620e47cf613462b9f293282a) {$v3d788fa62d7c185a1bee4c9147ee1091 = new DOMXPath($v9a09b4dfda82e3e665e31092d1c3ec8d);$result = $v3d788fa62d7c185a1bee4c9147ee1091->evaluate("/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение/Ид")->item($v95723b5e620e47cf613462b9f293282a - 1);if (!$result) return true;$v6c74fd3f117fcbf202f59252ae86a829 = explode("#", $result->nodeValue);$v8318b01e1a8adae250e10f59865350a8 = $v6c74fd3f117fcbf202f59252ae86a829[0];$vd200f13b21f81833671810b712a3c843 = new DOMXPath($vd60db28d94d538bbb249dcc7f2273ab1);$ve359afe8d4f61c75862074d230944711 = $vd200f13b21f81833671810b712a3c843->evaluate("/Предложение/Ид")->item(0);$vb37cad5b075e506361f94908486eb7b5 = explode("#", $ve359afe8d4f61c75862074d230944711->nodeValue);$vc3af03f3eff5beac337398bca2d5b52d = $vb37cad5b075e506361f94908486eb7b5[0];if ($v8318b01e1a8adae250e10f59865350a8 != $vc3af03f3eff5beac337398bca2d5b52d){return true;}else {return false;}}protected function readDataBlock() {$v4b43b0aee35624cd95b910189b3dc231 = new XMLReader;$v4b43b0aee35624cd95b910189b3dc231->open($this->file_path);$v2245023265ae4cf87d02c8b6ba991139 = mainConfiguration::getInstance();$vf7c163939469a0b7becb4e4e6a94efac = $v2245023265ae4cf87d02c8b6ba991139->includeParam('system.kernel') . 'subsystems/import/schemes/' . $this->type . '.xsd';if (is_file($vf7c163939469a0b7becb4e4e6a94efac)) {$v4b43b0aee35624cd95b910189b3dc231->setSchema($vf7c163939469a0b7becb4e4e6a94efac);}$v9a09b4dfda82e3e665e31092d1c3ec8d = new DomDocument("1.0", "utf-8");$v07214c6750d983a32e0a33da225c4efd = array(    "Группа",    "Товар",    "Предложение"   );$v95723b5e620e47cf613462b9f293282a = 0;$v4757fe07fd492a8be0ea6a760d683d6e = 0;$v5f0b6ebc4bea10285ba2b8a6ce78b863 = $v9a09b4dfda82e3e665e31092d1c3ec8d;$v7aa28ed115707345d0274032757e8991 = $v4b43b0aee35624cd95b910189b3dc231->read();while ($v7aa28ed115707345d0274032757e8991) {switch ($v4b43b0aee35624cd95b910189b3dc231->nodeType) {case XMLReader::ELEMENT: {if (in_array($v4b43b0aee35624cd95b910189b3dc231->name, $v07214c6750d983a32e0a33da225c4efd)) {if ($v4757fe07fd492a8be0ea6a760d683d6e++ < $this->offset) {$v7aa28ed115707345d0274032757e8991 = $v4b43b0aee35624cd95b910189b3dc231->next();continue(2);}if (($v95723b5e620e47cf613462b9f293282a + 1) > $this->block_size) {if ($v4b43b0aee35624cd95b910189b3dc231->name == "Предложение"){$vd60db28d94d538bbb249dcc7f2273ab1 = DOMDocument::loadXML($v4b43b0aee35624cd95b910189b3dc231->readOuterXML());if($this->__getOffersCompare($v9a09b4dfda82e3e665e31092d1c3ec8d, $vd60db28d94d538bbb249dcc7f2273ab1, $v95723b5e620e47cf613462b9f293282a)){break(2);}}else {break(2);}}$v95723b5e620e47cf613462b9f293282a++;}$v65c10911d8b8591219a21ebacf46da01 = $v9a09b4dfda82e3e665e31092d1c3ec8d->createElement($v4b43b0aee35624cd95b910189b3dc231->name, $v4b43b0aee35624cd95b910189b3dc231->value);$v5f0b6ebc4bea10285ba2b8a6ce78b863->appendChild($v65c10911d8b8591219a21ebacf46da01);if (!$v4b43b0aee35624cd95b910189b3dc231->isEmptyElement) {$v5f0b6ebc4bea10285ba2b8a6ce78b863 = $v65c10911d8b8591219a21ebacf46da01;}if ($v4b43b0aee35624cd95b910189b3dc231->attributeCount) {while ($v4b43b0aee35624cd95b910189b3dc231->moveToNextAttribute()) {$v815be97df65d6c4b510cd07189c5347a = $v9a09b4dfda82e3e665e31092d1c3ec8d->createAttribute($v4b43b0aee35624cd95b910189b3dc231->name);$v815be97df65d6c4b510cd07189c5347a->appendChild($v9a09b4dfda82e3e665e31092d1c3ec8d->createTextNode($v4b43b0aee35624cd95b910189b3dc231->value));$v65c10911d8b8591219a21ebacf46da01->appendChild($v815be97df65d6c4b510cd07189c5347a);}}$v3f02ab347aeca12e013036ce82046c38 = $this->__getNodePath($v5f0b6ebc4bea10285ba2b8a6ce78b863);if ($v3f02ab347aeca12e013036ce82046c38 == "КоммерческаяИнформация/Классификатор/Группы") {$v556216bbe3169f8132fe2b1683164988 = $v4b43b0aee35624cd95b910189b3dc231->readOuterXML();$v1471e4e05a4db95d353cc867fe317314 = DOMDocument::loadXML($v556216bbe3169f8132fe2b1683164988);$v076933917d4df1df9aeaf50e0d25297b = $v1471e4e05a4db95d353cc867fe317314->getElementsByTagName('Группа');foreach ($v076933917d4df1df9aeaf50e0d25297b as $vdb0f6f37ebeb6ea09489124345af2a45) {if ($v4757fe07fd492a8be0ea6a760d683d6e++ < $this->offset) continue;if (($v95723b5e620e47cf613462b9f293282a + 1) > $this->block_size) break;$this->__collectGroup($v9a09b4dfda82e3e665e31092d1c3ec8d, $v65c10911d8b8591219a21ebacf46da01, $vdb0f6f37ebeb6ea09489124345af2a45);$v95723b5e620e47cf613462b9f293282a++;}$v5f0b6ebc4bea10285ba2b8a6ce78b863 = $v5f0b6ebc4bea10285ba2b8a6ce78b863->parentNode;$v7aa28ed115707345d0274032757e8991 = $v4b43b0aee35624cd95b910189b3dc231->next();continue(2);}}break;case XMLReader::END_ELEMENT: {$v5f0b6ebc4bea10285ba2b8a6ce78b863 = $v5f0b6ebc4bea10285ba2b8a6ce78b863->parentNode;}break;case XMLReader::ATTRIBUTE: {$v815be97df65d6c4b510cd07189c5347a = $v9a09b4dfda82e3e665e31092d1c3ec8d->createAttribute($v4b43b0aee35624cd95b910189b3dc231->name);$v815be97df65d6c4b510cd07189c5347a->appendChild($v9a09b4dfda82e3e665e31092d1c3ec8d->createTextNode($v4b43b0aee35624cd95b910189b3dc231->value));$v5f0b6ebc4bea10285ba2b8a6ce78b863->appendChild($v815be97df65d6c4b510cd07189c5347a);}break;case XMLReader::TEXT: {$vc7824f3d4d5f7b2f22d034758c1e9454 =  $v9a09b4dfda82e3e665e31092d1c3ec8d->createTextNode($v4b43b0aee35624cd95b910189b3dc231->value);$v5f0b6ebc4bea10285ba2b8a6ce78b863->appendChild($vc7824f3d4d5f7b2f22d034758c1e9454);}break;case XMLReader::CDATA: {$vd9ef6bda8fb69f1c7e277bd1c2cd21d1 =  $v9a09b4dfda82e3e665e31092d1c3ec8d->createCDATASection($v4b43b0aee35624cd95b910189b3dc231->value);$v5f0b6ebc4bea10285ba2b8a6ce78b863->appendChild($vd9ef6bda8fb69f1c7e277bd1c2cd21d1);}break;case XMLReader::NONE:     default:    }$v7aa28ed115707345d0274032757e8991 = $v4b43b0aee35624cd95b910189b3dc231->read();}$this->offset += $v95723b5e620e47cf613462b9f293282a;if (!$v7aa28ed115707345d0274032757e8991) $this->complete = true;return $v9a09b4dfda82e3e665e31092d1c3ec8d;}public function getRenameFiles() {$v2245023265ae4cf87d02c8b6ba991139 = mainConfiguration::getInstance();$v82e493c80beeab7a6e841aa86ea2c6ad = $v2245023265ae4cf87d02c8b6ba991139->get("modules", "exchange.commerceML.renameFiles") !== null ? $v2245023265ae4cf87d02c8b6ba991139->get("modules", "exchange.commerceML.renameFiles") : $this->renameFiles;return (bool) $v82e493c80beeab7a6e841aa86ea2c6ad;}}?>