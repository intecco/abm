<?php
 class selectorExecutor {protected   $selector,   $queryColumns = array(),   $queryTables = array(),   $queryJoinTables = array(),   $queryLimit = array(),   $queryFields = array(),   $queryOptions = array(),   $length = null,   $skipExecutedCheck = false;public function __construct(selector $v5b3c32009797feb79096d52e56a56b82) {$this->selector = $v5b3c32009797feb79096d52e56a56b82;$this->analyze();}public function query() {return $this->buildQuery('result');}public function result() {$vac5c74b64b4b8352ef2f181affb5ac2a = $this->buildQuery('result');if(defined('DEBUG_SQL_SELECTOR')) {$v7f2db423a49b305459147332fb01cf87 = outputBuffer::current();$v7f2db423a49b305459147332fb01cf87->push($vac5c74b64b4b8352ef2f181affb5ac2a . "\n\n\n");}$v4717d53ebfdfea8477f780ec66151dcb = ConnectionPool::getInstance()->getConnection();$result = $v4717d53ebfdfea8477f780ec66151dcb->query($vac5c74b64b4b8352ef2f181affb5ac2a);$ve70c4df10ef0983b9c8c31bd06b2a2c3 = $this->selector->option('return')->value;if(!DISABLE_CALC_FOUND_ROWS) {$v770c639e20ac2f19c5ae0da373080e25 = l_mysql_query("SELECT FOUND_ROWS()", true);list($ve2942a04780e223b215eb8b663cf5353) = mysql_fetch_row($v770c639e20ac2f19c5ae0da373080e25);mysql_free_result($v770c639e20ac2f19c5ae0da373080e25);$this->length = (int) $ve2942a04780e223b215eb8b663cf5353;}if($this->selector->mode == 'objects') {$v10ae9fc7d453b0dd525d0edf2ede7961 = array();$v5891da2d64975cae48d175d1e001f5da = umiObjectsCollection::getInstance();while($vf1965a857bc285d26fe22023aa5ab50d = mysql_fetch_row($result)) {list($v16b2b26000987faccb260b9d39df1269) = $vf1965a857bc285d26fe22023aa5ab50d;if (is_array($ve70c4df10ef0983b9c8c31bd06b2a2c3) && sizeof($ve70c4df10ef0983b9c8c31bd06b2a2c3)) {if (sizeof($ve70c4df10ef0983b9c8c31bd06b2a2c3) == 1 && $ve70c4df10ef0983b9c8c31bd06b2a2c3[0] == 'id') {$v10ae9fc7d453b0dd525d0edf2ede7961[] = array('id' => $v16b2b26000987faccb260b9d39df1269);}else {$va8cfde6331bd59eb2ac96f8911c4b666 = $v5891da2d64975cae48d175d1e001f5da->getObject($v16b2b26000987faccb260b9d39df1269, array_slice($vf1965a857bc285d26fe22023aa5ab50d, 1));$vae50a11a070db2b31891ed57c8a26a15 = array();foreach ($ve70c4df10ef0983b9c8c31bd06b2a2c3 as $v73f329f154a663bfda020aadcdd0b775) {switch ($v73f329f154a663bfda020aadcdd0b775) {case "id": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v16b2b26000987faccb260b9d39df1269;break;case "name": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $va8cfde6331bd59eb2ac96f8911c4b666->getName();break;case "guid": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $va8cfde6331bd59eb2ac96f8911c4b666->getGUID();break;default :          $v06e3d36fa30cea095545139854ad1fb9 = $va8cfde6331bd59eb2ac96f8911c4b666->getValue($v73f329f154a663bfda020aadcdd0b775);$vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v06e3d36fa30cea095545139854ad1fb9 ? $v06e3d36fa30cea095545139854ad1fb9 : false;}}$v10ae9fc7d453b0dd525d0edf2ede7961[] = $vae50a11a070db2b31891ed57c8a26a15;}}else {$va8cfde6331bd59eb2ac96f8911c4b666 = $v5891da2d64975cae48d175d1e001f5da->getObject($v16b2b26000987faccb260b9d39df1269, array_slice($vf1965a857bc285d26fe22023aa5ab50d, 1));if($va8cfde6331bd59eb2ac96f8911c4b666 instanceof iUmiObject) {$v10ae9fc7d453b0dd525d0edf2ede7961[] = $va8cfde6331bd59eb2ac96f8911c4b666;}}}return $v10ae9fc7d453b0dd525d0edf2ede7961;}else {$vbf516925bb37a8544c8ee19a24e15c05 = array();while($vf1965a857bc285d26fe22023aa5ab50d = mysql_fetch_assoc($result)) {$vb80bb7740288fda1f201890375a60c8f = (int) $vf1965a857bc285d26fe22023aa5ab50d['id'];$v0db3209e1adc6d67be435a81baf9a66e = isset($vf1965a857bc285d26fe22023aa5ab50d['pid']) ? (int) $vf1965a857bc285d26fe22023aa5ab50d['pid'] : 0;$vbf516925bb37a8544c8ee19a24e15c05[$vb80bb7740288fda1f201890375a60c8f] = $v0db3209e1adc6d67be435a81baf9a66e;}if($this->selector->option('exclude-nested')->value) {$va7ef1586e4bce6064f74264fbbab9165 = $this->excludeNestedPages($vbf516925bb37a8544c8ee19a24e15c05);$this->length = sizeof($va7ef1586e4bce6064f74264fbbab9165);if($this->selector->limit || $this->selector->offset) {$va7ef1586e4bce6064f74264fbbab9165 = array_slice($va7ef1586e4bce6064f74264fbbab9165, $this->selector->offset, $this->selector->limit);}}else {$va7ef1586e4bce6064f74264fbbab9165 = array_keys($vbf516925bb37a8544c8ee19a24e15c05);}$v10ae9fc7d453b0dd525d0edf2ede7961 = array();if(count($va7ef1586e4bce6064f74264fbbab9165)) {$vac5c74b64b4b8352ef2f181affb5ac2a = "SELECT h.id, h.rel, h.type_id, h.lang_id, h.domain_id, h.tpl_id, h.obj_id, h.ord, h.alt_name, h.is_active, h.is_visible, h.is_deleted, h.updatetime, h.is_default, o.name FROM cms3_hierarchy h, cms3_objects o WHERE h.id IN (" . implode(',', $va7ef1586e4bce6064f74264fbbab9165) . ") AND o.id = h.obj_id";$result = $v4717d53ebfdfea8477f780ec66151dcb->queryResult($vac5c74b64b4b8352ef2f181affb5ac2a);$result->setFetchType(IQueryResult::FETCH_ROW);$v10ae9fc7d453b0dd525d0edf2ede7961 = array_flip($va7ef1586e4bce6064f74264fbbab9165);$vb81ca7c0ccaa77e7aa91936ab0070695 = umiHierarchy::getInstance();foreach($result as $vf1965a857bc285d26fe22023aa5ab50d) {$v7552cd149af7495ee7d8225974e50f80 = array_shift($vf1965a857bc285d26fe22023aa5ab50d);if (sizeof($ve70c4df10ef0983b9c8c31bd06b2a2c3)) {if (sizeof($ve70c4df10ef0983b9c8c31bd06b2a2c3) == 1 && $ve70c4df10ef0983b9c8c31bd06b2a2c3[0] == 'id') {$v10ae9fc7d453b0dd525d0edf2ede7961[$v7552cd149af7495ee7d8225974e50f80] = array('id' => $v7552cd149af7495ee7d8225974e50f80);}else {$v8e2dcfd7e7e24b1ca76c1193f645902b = $vb81ca7c0ccaa77e7aa91936ab0070695->getElement($v7552cd149af7495ee7d8225974e50f80);$vae50a11a070db2b31891ed57c8a26a15 = array();foreach ($ve70c4df10ef0983b9c8c31bd06b2a2c3 as $v73f329f154a663bfda020aadcdd0b775) {switch ($v73f329f154a663bfda020aadcdd0b775) {case "id": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v7552cd149af7495ee7d8225974e50f80;break;case "name": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v8e2dcfd7e7e24b1ca76c1193f645902b->getName();break;case "alt_name": $vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v8e2dcfd7e7e24b1ca76c1193f645902b->getAltName();break;default :           $v06e3d36fa30cea095545139854ad1fb9 = $v8e2dcfd7e7e24b1ca76c1193f645902b->getValue($v73f329f154a663bfda020aadcdd0b775);$vae50a11a070db2b31891ed57c8a26a15[$v73f329f154a663bfda020aadcdd0b775] = $v06e3d36fa30cea095545139854ad1fb9 ? $v06e3d36fa30cea095545139854ad1fb9 : false;}}$v10ae9fc7d453b0dd525d0edf2ede7961[$v7552cd149af7495ee7d8225974e50f80] = $vae50a11a070db2b31891ed57c8a26a15;}}else {$v8e2dcfd7e7e24b1ca76c1193f645902b = $vb81ca7c0ccaa77e7aa91936ab0070695->getElement($v7552cd149af7495ee7d8225974e50f80, false, false, $vf1965a857bc285d26fe22023aa5ab50d);if($v8e2dcfd7e7e24b1ca76c1193f645902b instanceof iUmiHierarchyElement) {$v10ae9fc7d453b0dd525d0edf2ede7961[$v7552cd149af7495ee7d8225974e50f80] = $v8e2dcfd7e7e24b1ca76c1193f645902b;}}}$v10ae9fc7d453b0dd525d0edf2ede7961 = array_values($v10ae9fc7d453b0dd525d0edf2ede7961);}return $v10ae9fc7d453b0dd525d0edf2ede7961;}}public function length() {if(!is_null($this->length)) {return $this->length;}$this->skipExecutedCheck = true;if(count($this->selector->groupSysProps) || count($this->selector->groupFieldProps)) {$vac5c74b64b4b8352ef2f181affb5ac2a = $this->buildQuery('result');}else {$vac5c74b64b4b8352ef2f181affb5ac2a = $this->buildQuery('count');}$this->skipExecutedCheck = false;$result = l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);if(count($this->selector->groupSysProps) || count($this->selector->groupFieldProps)) {$ve2942a04780e223b215eb8b663cf5353 = mysql_num_rows($result);}else {list($ve2942a04780e223b215eb8b663cf5353) = mysql_fetch_row($result);}return $this->length = (int) $ve2942a04780e223b215eb8b663cf5353;}public static function getContentTableName(selector $v5b3c32009797feb79096d52e56a56b82, $v945100186b119048837b9859c2c46410) {if(!is_null($v945100186b119048837b9859c2c46410) && self::getFieldColumn($v945100186b119048837b9859c2c46410) == 'cnt') {return 'cms3_object_content_cnt';}$v0e8133eb006c0f85ed9444ae07a60842 = array();$v6942e8fa62b3cc9d93881a58210e2fd7 = array();$vd14a8022b085f9ef19d479cbdd581127 = $v5b3c32009797feb79096d52e56a56b82->types;foreach($vd14a8022b085f9ef19d479cbdd581127 as $v599dcce2998a6b40b1e38e8c6006cb0a) {if(is_null($v599dcce2998a6b40b1e38e8c6006cb0a->objectType) == false) $v0e8133eb006c0f85ed9444ae07a60842[] = $v599dcce2998a6b40b1e38e8c6006cb0a->objectType->getId();if(is_null($v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType) == false) {$v89b0b9deff65f8b9cd1f71bc74ce36ba = $v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType;if($v89b0b9deff65f8b9cd1f71bc74ce36ba->getModule() == 'comments') continue;$v6942e8fa62b3cc9d93881a58210e2fd7[] = $v89b0b9deff65f8b9cd1f71bc74ce36ba->getId();}}if(sizeof($v0e8133eb006c0f85ed9444ae07a60842)) {return umiBranch::getBranchedTableByTypeId(array_pop($v0e8133eb006c0f85ed9444ae07a60842));}if(sizeof($v6942e8fa62b3cc9d93881a58210e2fd7)) {$vacf567c9c3d6cf7c6e2cc0ce108e0631 = array_pop($v6942e8fa62b3cc9d93881a58210e2fd7);if(umiBranch::checkIfBranchedByHierarchyTypeId($vacf567c9c3d6cf7c6e2cc0ce108e0631)) {return 'cms3_object_content_' . $vacf567c9c3d6cf7c6e2cc0ce108e0631;}}return 'cms3_object_content';}public function getSkipExecutedCheckState() {return $this->skipExecutedCheck;}protected function analyze() {$v5b3c32009797feb79096d52e56a56b82 = $this->selector;switch($v5b3c32009797feb79096d52e56a56b82->mode) {case 'objects':     $this->requireTable('o', 'cms3_objects');$this->requireTable('t', 'cms3_object_types');break;case 'pages':     $this->requireTable('h', 'cms3_hierarchy');break;}$this->analyzeFields();$this->analyzeLimit();}protected function requireTable($v724874d1be77f450a09b305fc1534afb, $v80071f37861c360a27b7327e132c911a) {$this->queryTables[$v724874d1be77f450a09b305fc1534afb] = $v80071f37861c360a27b7327e132c911a;}protected function requireSysProp($v46b9e6004c49d9cc040029c197cab278) {$v90e46a37654bd99f32b7dce981c0d9a0 = array();$v90e46a37654bd99f32b7dce981c0d9a0['name'] = array('o.name', 'table' => array('o', 'cms3_objects'));$v90e46a37654bd99f32b7dce981c0d9a0['guid'] = array('o.guid', 'table' => array('o', 'cms3_objects'));$v90e46a37654bd99f32b7dce981c0d9a0['owner'] = array('o.owner_id', 'table' => array('o', 'cms3_objects'));$v90e46a37654bd99f32b7dce981c0d9a0['domain'] = array('h.domain_id');$v90e46a37654bd99f32b7dce981c0d9a0['lang'] = array('h.lang_id');$v90e46a37654bd99f32b7dce981c0d9a0['is_deleted'] = array('h.is_deleted');$v90e46a37654bd99f32b7dce981c0d9a0['is_default'] = array('h.is_default');$v90e46a37654bd99f32b7dce981c0d9a0['is_visible'] = array('h.is_visible');$v90e46a37654bd99f32b7dce981c0d9a0['is_active'] = array('h.is_active');$v90e46a37654bd99f32b7dce981c0d9a0['domain'] = array('h.domain_id');$v90e46a37654bd99f32b7dce981c0d9a0['updatetime'] = array('h.updatetime');$v90e46a37654bd99f32b7dce981c0d9a0['rand'] = array('RAND()');$v90e46a37654bd99f32b7dce981c0d9a0['template_id'] = array('h.tpl_id');if($this->selector->mode == 'pages') {$v90e46a37654bd99f32b7dce981c0d9a0['ord'] = array('h.ord', 'table' => array('h', 'cms3_hierarchy'));}if($v46b9e6004c49d9cc040029c197cab278 == 'id') {$v90e46a37654bd99f32b7dce981c0d9a0['id'] = array('o.id', 'table' => array('o', 'cms3_objects'));};if(isset($v90e46a37654bd99f32b7dce981c0d9a0[$v46b9e6004c49d9cc040029c197cab278])) {$vcaf9b6b99962bf5c2264824231d7a40c = $v90e46a37654bd99f32b7dce981c0d9a0[$v46b9e6004c49d9cc040029c197cab278];if(isset($vcaf9b6b99962bf5c2264824231d7a40c['table'])) {$this->requireTable($vcaf9b6b99962bf5c2264824231d7a40c['table'][0], $vcaf9b6b99962bf5c2264824231d7a40c['table'][1]);}return $vcaf9b6b99962bf5c2264824231d7a40c[0];}else {throw new selectorException("Not supported property \"{$v46b9e6004c49d9cc040029c197cab278}\"");}}protected function analyzeFields() {$v5b3c32009797feb79096d52e56a56b82 = $this->selector;$v4d15c1a5147ac6e7c61f1f05cc0339bc = $v5b3c32009797feb79096d52e56a56b82->whereFieldProps;$vd05b6ed7d2345020440df396d6da7f73 = array();foreach($v4d15c1a5147ac6e7c61f1f05cc0339bc as $v06e3d36fa30cea095545139854ad1fb9) {$vd05b6ed7d2345020440df396d6da7f73[] = $v06e3d36fa30cea095545139854ad1fb9->fieldId;}$vd05b6ed7d2345020440df396d6da7f73 = array_unique($vd05b6ed7d2345020440df396d6da7f73);foreach($vd05b6ed7d2345020440df396d6da7f73 as $v945100186b119048837b9859c2c46410) {$v80071f37861c360a27b7327e132c911a = self::getContentTableName($v5b3c32009797feb79096d52e56a56b82, $v945100186b119048837b9859c2c46410);$this->requireTable('oc_' . $v945100186b119048837b9859c2c46410, $v80071f37861c360a27b7327e132c911a);$this->queryFields[] = $v945100186b119048837b9859c2c46410;}}protected function analyzeLimit() {$v5b3c32009797feb79096d52e56a56b82 = $this->selector;if($v5b3c32009797feb79096d52e56a56b82->option('exclude-nested')->value) {return;}if($v5b3c32009797feb79096d52e56a56b82->limit || $v5b3c32009797feb79096d52e56a56b82->offset) {$this->queryLimit = array((int) $v5b3c32009797feb79096d52e56a56b82->offset, (int) $v5b3c32009797feb79096d52e56a56b82->limit);}}protected function buildQuery($v15d61712450a686a7f365adf4fef581f) {if($v15d61712450a686a7f365adf4fef581f == 'result') {if($this->selector->mode == 'objects') {$this->queryColumns = array('o.id as id', 'o.name as name', 'o.type_id as type_id', 'o.is_locked as is_locked', 'o.owner_id as owner_id', 'o.guid as guid', 't.guid as type_guid');}else {$this->queryColumns = array('h.id as id', 'h.rel as pid');}}else {$this->queryColumns = ($this->selector->mode == 'objects') ? array('COUNT(o.id)') : array('COUNT(h.id)');}if($this->selector->option('root')->value) {return $this->buildRootQuery($v15d61712450a686a7f365adf4fef581f);}$v5a6f85b0e2c34b7c96af65b0f54b4dea = $this->buildColumns();$vc6c12f4db6ba0426c8e023cb1ca31038 = $this->buildLimit();$va85bfb9c6bcd889ceb433a1c9cd4b218 = $this->buildOrder();$ve22c565b90e9a278849f2d61d78e8388 = $this->buildGroup();$vccc9e74cf27019ed02701010da900d6d = $this->buildWhere();$v0b63a75de116aadef5f4aed3dc3b7d87 = $this->buildLeftJoins();$v75a8be0fca0bc0497c40180b6d02d580 = $this->buildTables();$v39daa41bf389071ad9cd7a7a0ad2ff2c = $this->buildOptions($v15d61712450a686a7f365adf4fef581f);return <<<SQL
SELECT {$v39daa41bf389071ad9cd7a7a0ad2ff2c} {$v5a6f85b0e2c34b7c96af65b0f54b4dea}
	FROM {$v75a8be0fca0bc0497c40180b6d02d580}
	{$v0b63a75de116aadef5f4aed3dc3b7d87}
	{$vccc9e74cf27019ed02701010da900d6d}
	{$va85bfb9c6bcd889ceb433a1c9cd4b218}
	{$ve22c565b90e9a278849f2d61d78e8388}
	{$vc6c12f4db6ba0426c8e023cb1ca31038}
SQL;  }protected function buildOptions($v15d61712450a686a7f365adf4fef581f) {$v56b07ca9227f50ef928ccc932038180f = $this->queryOptions;$v56b07ca9227f50ef928ccc932038180f = array_unique($v56b07ca9227f50ef928ccc932038180f);if(MAX_SELECTION_TABLE_JOINS > 0 && MAX_SELECTION_TABLE_JOINS < sizeof($this->queryJoinTables)) {$v56b07ca9227f50ef928ccc932038180f[] = 'STRAIGHT_JOIN';}if($v15d61712450a686a7f365adf4fef581f == 'result') {if(!DISABLE_CALC_FOUND_ROWS) {$v56b07ca9227f50ef928ccc932038180f[] = 'SQL_CALC_FOUND_ROWS';}}return implode(' ', $v56b07ca9227f50ef928ccc932038180f);}protected function buildLeftJoins() {$va12b4ea43cb390c701ca21b24717887a = array();$v0cc53116375bee4529f23b0f2f407df5 = array_merge($this->selector->orderFieldProps, $this->selector->whereFieldProps);$vbdf7216b52ab1c35e07a5ba2def35348 = array();foreach($v0cc53116375bee4529f23b0f2f407df5 as $v8040c3c227f813496fd957249478b6e3) {$v945100186b119048837b9859c2c46410 = $v8040c3c227f813496fd957249478b6e3->fieldId;if (!in_array($v945100186b119048837b9859c2c46410, $vbdf7216b52ab1c35e07a5ba2def35348)) {$this->requireTable('o', 'cms3_objects');$v80071f37861c360a27b7327e132c911a = self::getContentTableName($this->selector, $v945100186b119048837b9859c2c46410);$v731b886d80d2ea138da54d30f43b2005 = "LEFT JOIN {$v80071f37861c360a27b7327e132c911a} oc_{$v945100186b119048837b9859c2c46410}_lj ON oc_{$v945100186b119048837b9859c2c46410}_lj.obj_id=o.id AND oc_{$v945100186b119048837b9859c2c46410}_lj.field_id = '{$v945100186b119048837b9859c2c46410}'";$va12b4ea43cb390c701ca21b24717887a[] = $v731b886d80d2ea138da54d30f43b2005;$vbdf7216b52ab1c35e07a5ba2def35348[] = $v945100186b119048837b9859c2c46410;$this->queryJoinTables[] = $v80071f37861c360a27b7327e132c911a;}}return empty($va12b4ea43cb390c701ca21b24717887a) ? "" : implode(" ", $va12b4ea43cb390c701ca21b24717887a);}protected function buildColumns() {return implode(', ', $this->queryColumns);}protected function buildTables() {$v9ab2ec7ea4a2041306f7bdf150fcd453 = array();$v00a9a809ad34d904aba9c5b4875643e2 = false;foreach($this->queryTables as $v724874d1be77f450a09b305fc1534afb => $vb068931cc450442b63f5b3d276ea4297) {if ($vb068931cc450442b63f5b3d276ea4297 == 'cms3_objects' && $v00a9a809ad34d904aba9c5b4875643e2 === false) {$v00a9a809ad34d904aba9c5b4875643e2 = $v724874d1be77f450a09b305fc1534afb;continue;}if ($vb068931cc450442b63f5b3d276ea4297 == 'cms3_object_content' && $v724874d1be77f450a09b305fc1534afb != 'o_asteriks') continue;$v9ab2ec7ea4a2041306f7bdf150fcd453[] = $vb068931cc450442b63f5b3d276ea4297 . ' ' . $v724874d1be77f450a09b305fc1534afb;}if($v00a9a809ad34d904aba9c5b4875643e2 !== false) {$v9ab2ec7ea4a2041306f7bdf150fcd453[] = $this->queryTables[$v00a9a809ad34d904aba9c5b4875643e2] . ' ' . $v00a9a809ad34d904aba9c5b4875643e2;}return implode(', ', $v9ab2ec7ea4a2041306f7bdf150fcd453);}protected function buildLimit() {if(sizeof($this->queryLimit)) {return " LIMIT {$this->queryLimit[0]}, {$this->queryLimit[1]}";}else {return "";}}protected function buildWhere() {$vac5c74b64b4b8352ef2f181affb5ac2a = "";$vb71a97a0f96cb8b238309d23a188ae98 = array();$v0e8133eb006c0f85ed9444ae07a60842 = array();$v6942e8fa62b3cc9d93881a58210e2fd7 = array();foreach($this->selector->types as $v599dcce2998a6b40b1e38e8c6006cb0a) {if(is_null($v599dcce2998a6b40b1e38e8c6006cb0a->objectType) == false) $v0e8133eb006c0f85ed9444ae07a60842[] = $v599dcce2998a6b40b1e38e8c6006cb0a->objectType->getId();if(is_null($v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType) == false) $v6942e8fa62b3cc9d93881a58210e2fd7[] = $v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType->getId();}if(sizeof($v0e8133eb006c0f85ed9444ae07a60842)) {$this->requireTable('o', 'cms3_objects');$this->requireTable('t', 'cms3_object_types');$vb3827f7111095f5ba1a9f49988fe9382 = umiObjectTypesCollection::getInstance();$veb52d3ec890b2d484d6630771e37554c = array();foreach($v0e8133eb006c0f85ed9444ae07a60842 as $v6301cee35ea764a1e241978f93f01069) {$veb52d3ec890b2d484d6630771e37554c = array_merge($veb52d3ec890b2d484d6630771e37554c, $vb3827f7111095f5ba1a9f49988fe9382->getChildClasses($v6301cee35ea764a1e241978f93f01069));}$v0e8133eb006c0f85ed9444ae07a60842 = array_unique(array_merge($v0e8133eb006c0f85ed9444ae07a60842, $veb52d3ec890b2d484d6630771e37554c));$vb71a97a0f96cb8b238309d23a188ae98[] = 'o.type_id IN (' . implode(', ', $v0e8133eb006c0f85ed9444ae07a60842) . ')';$vb71a97a0f96cb8b238309d23a188ae98[] = 't.id = o.type_id';}if(sizeof($v6942e8fa62b3cc9d93881a58210e2fd7)) {$v6942e8fa62b3cc9d93881a58210e2fd7 = array_unique($v6942e8fa62b3cc9d93881a58210e2fd7);$vb71a97a0f96cb8b238309d23a188ae98[] = 'h.type_id IN (' . implode(', ', $v6942e8fa62b3cc9d93881a58210e2fd7) . ')';}if(sizeof($this->queryFields)) {$this->requireTable('o', 'cms3_objects');}$v6d7c8db4f8b49f97b93014d8ff3a1d2d     = umiFieldsCollection::getInstance();$v9129be9157de7546ad9a50df5f46dda3        = $this->selector->option('or-mode');$vc2451bc29e93cf5592f4e9e0905fc76a    = array();$va0705b747cdc4dc7dbc5e6260e204157 = array();$vabf1da7c42b3413c5be3d8d906f3630d = '';foreach($this->queryFields as $v945100186b119048837b9859c2c46410) {if (isset($v9129be9157de7546ad9a50df5f46dda3->value['fields']) && in_array($v6d7c8db4f8b49f97b93014d8ff3a1d2d->getField($v945100186b119048837b9859c2c46410)->getName(), $v9129be9157de7546ad9a50df5f46dda3->value['fields'])) {$va0705b747cdc4dc7dbc5e6260e204157[] = $this->buildWhereValue($v945100186b119048837b9859c2c46410);}else $vc2451bc29e93cf5592f4e9e0905fc76a[] = $this->buildWhereValue($v945100186b119048837b9859c2c46410);}if(sizeof($vc2451bc29e93cf5592f4e9e0905fc76a) || sizeof($va0705b747cdc4dc7dbc5e6260e204157)) {if (isset($v9129be9157de7546ad9a50df5f46dda3->value['all'])) {$vc2451bc29e93cf5592f4e9e0905fc76a = array_merge($vc2451bc29e93cf5592f4e9e0905fc76a, $va0705b747cdc4dc7dbc5e6260e204157);$vabf1da7c42b3413c5be3d8d906f3630d = implode(' OR ', $vc2451bc29e93cf5592f4e9e0905fc76a);}else {if (sizeof($vc2451bc29e93cf5592f4e9e0905fc76a)) {$vabf1da7c42b3413c5be3d8d906f3630d .= implode(' AND ', $vc2451bc29e93cf5592f4e9e0905fc76a);if (sizeof($va0705b747cdc4dc7dbc5e6260e204157)) $vabf1da7c42b3413c5be3d8d906f3630d .= ' AND ';}if (sizeof($va0705b747cdc4dc7dbc5e6260e204157)) {$vabf1da7c42b3413c5be3d8d906f3630d .= (sizeof($va0705b747cdc4dc7dbc5e6260e204157) > 1) ? "(" . implode(' OR ', $va0705b747cdc4dc7dbc5e6260e204157) . ")" : $va0705b747cdc4dc7dbc5e6260e204157[0];}}$vb71a97a0f96cb8b238309d23a188ae98[] = '('. $vabf1da7c42b3413c5be3d8d906f3630d . ')';}$v620d6d4d09a18d4c5fdc7fa1abae6149 = $this->selector->whereSysProps;foreach($v620d6d4d09a18d4c5fdc7fa1abae6149 as $ve7b2acf954344b64ff7a1bdef7490812) {if($v26542fb18a8b14c9775aa475f23c909f = $this->buildSysProp($ve7b2acf954344b64ff7a1bdef7490812)) {$vb71a97a0f96cb8b238309d23a188ae98[] = $v26542fb18a8b14c9775aa475f23c909f;}}if($this->selector->mode == 'pages') {if($vc59a4dbfd0b091548a2f1d692a2a7c01 = $this->buildPermissions()) {$vb71a97a0f96cb8b238309d23a188ae98[] = $vc59a4dbfd0b091548a2f1d692a2a7c01;}if($v5b20cfc8862f370a9201f62df14c09c2 = $this->buildHierarchy()) {$vb71a97a0f96cb8b238309d23a188ae98[] = $v5b20cfc8862f370a9201f62df14c09c2;}if(isset($this->queryTables['o'])) {$vb71a97a0f96cb8b238309d23a188ae98[] = "h.obj_id = o.id";}}$vac5c74b64b4b8352ef2f181affb5ac2a .= implode(' AND ', $vb71a97a0f96cb8b238309d23a188ae98);if($vac5c74b64b4b8352ef2f181affb5ac2a) $vac5c74b64b4b8352ef2f181affb5ac2a = "WHERE " . $vac5c74b64b4b8352ef2f181affb5ac2a;return $vac5c74b64b4b8352ef2f181affb5ac2a;}protected function buildWhereValue($v945100186b119048837b9859c2c46410) {$v173936e059d215ede2e8b723a6165878 = $this->selector->whereFieldProps;$v43b5c9175984c071f30b873fdce0a000 = array();foreach($v173936e059d215ede2e8b723a6165878 as $v567904efe9e64d9faf3e41ef402cb568) {if($v567904efe9e64d9faf3e41ef402cb568->fieldId == $v945100186b119048837b9859c2c46410) $v43b5c9175984c071f30b873fdce0a000[] = $v567904efe9e64d9faf3e41ef402cb568;}$v1afd32818d1c9525f82aff4c09efd254 = self::getFieldColumn($v945100186b119048837b9859c2c46410);$vac5c74b64b4b8352ef2f181affb5ac2a = "";$vb71a97a0f96cb8b238309d23a188ae98 = array();foreach($v43b5c9175984c071f30b873fdce0a000 as $v567904efe9e64d9faf3e41ef402cb568) {if($v1afd32818d1c9525f82aff4c09efd254 === false) {if(sizeof($v567904efe9e64d9faf3e41ef402cb568->value) == 1) {$v14f802e1fba977727845e8872c1743a7 = array_keys($v567904efe9e64d9faf3e41ef402cb568->value);$v1afd32818d1c9525f82aff4c09efd254 = array_pop($v14f802e1fba977727845e8872c1743a7) . '_val';}else continue;}$v3f9178c25b78ed8bed19091bcb62e266 = $this->parseValue($v567904efe9e64d9faf3e41ef402cb568->mode, $v567904efe9e64d9faf3e41ef402cb568->value, "oc_{$v945100186b119048837b9859c2c46410}_lj.{$v1afd32818d1c9525f82aff4c09efd254}");$vb71a97a0f96cb8b238309d23a188ae98[] = ($v567904efe9e64d9faf3e41ef402cb568->mode == 'notequals') ? "(oc_{$v945100186b119048837b9859c2c46410}_lj.{$v1afd32818d1c9525f82aff4c09efd254}{$v3f9178c25b78ed8bed19091bcb62e266})" : "oc_{$v945100186b119048837b9859c2c46410}_lj.{$v1afd32818d1c9525f82aff4c09efd254}{$v3f9178c25b78ed8bed19091bcb62e266}";}$v06e3d36fa30cea095545139854ad1fb9 = umiFieldsCollection::getInstance()->getField($v945100186b119048837b9859c2c46410);$v9129be9157de7546ad9a50df5f46dda3 = $this->selector->option('or-mode');if (isset($v9129be9157de7546ad9a50df5f46dda3->value['all']) || (isset($v9129be9157de7546ad9a50df5f46dda3->value['field']) && in_array($v06e3d36fa30cea095545139854ad1fb9->getName(), $v9129be9157de7546ad9a50df5f46dda3->value['field']))) {$veaae0796859eed71de2b22d27b57296b = ' OR ';$this->queryOptions[] = 'DISTINCT';}else {$veaae0796859eed71de2b22d27b57296b = ' AND ';}$vac5c74b64b4b8352ef2f181affb5ac2a = implode($veaae0796859eed71de2b22d27b57296b, array_unique($vb71a97a0f96cb8b238309d23a188ae98));return $vac5c74b64b4b8352ef2f181affb5ac2a ? (sizeof($vb71a97a0f96cb8b238309d23a188ae98) > 1 ? "(" . $vac5c74b64b4b8352ef2f181affb5ac2a . ")" : $vac5c74b64b4b8352ef2f181affb5ac2a) : "";}protected function parseValue($v15d61712450a686a7f365adf4fef581f, $v2063c1608d6e0baf80249c42e2be5804, $v1afd32818d1c9525f82aff4c09efd254 = false) {switch($v15d61712450a686a7f365adf4fef581f) {case 'equals':     if(is_array($v2063c1608d6e0baf80249c42e2be5804) || is_object($v2063c1608d6e0baf80249c42e2be5804)) {$v2063c1608d6e0baf80249c42e2be5804 = $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);if(sizeof($v2063c1608d6e0baf80249c42e2be5804)) {return ' IN(' . implode(', ', $v2063c1608d6e0baf80249c42e2be5804) . ')';}else {return ' = 0 = 1';}}else      return ' = ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);break;case 'notequals':     if(is_array($v2063c1608d6e0baf80249c42e2be5804) || is_object($v2063c1608d6e0baf80249c42e2be5804)) {$v2063c1608d6e0baf80249c42e2be5804 = $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);if(sizeof($v2063c1608d6e0baf80249c42e2be5804)) {return ' NOT IN(' . implode(', ', $v2063c1608d6e0baf80249c42e2be5804) . ')' . ($v1afd32818d1c9525f82aff4c09efd254 ? " OR {$v1afd32818d1c9525f82aff4c09efd254} IS NULL" : "");}else {return ' = 0 = 1';}}else      return ' != ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804) . ($v1afd32818d1c9525f82aff4c09efd254 ? " OR {$v1afd32818d1c9525f82aff4c09efd254} IS NULL" : "");break;case 'like':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' LIKE ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'ilike':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' LIKE ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'more':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' > ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'eqmore':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' >= ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'less':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' < ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'eqless':     if(is_array($v2063c1608d6e0baf80249c42e2be5804)) throw new selectorException("Method \"{$v15d61712450a686a7f365adf4fef581f}\" can't accept array");else return ' <= ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804);case 'between':     return ' BETWEEN ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804[0]) . ' AND ' . $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804[1]);case 'isnotnull':     $v2063c1608d6e0baf80249c42e2be5804 != $v2063c1608d6e0baf80249c42e2be5804;case 'isnull':     return ($v2063c1608d6e0baf80249c42e2be5804) ? ' IS NULL' : ' IS NOT NULL';default:     throw new selectorException("Unsupported field mode \"{$v15d61712450a686a7f365adf4fef581f}\"");}}protected function buildSysProp($v23a5b8ab834cb5140fa6665622eb6417) {if($v23a5b8ab834cb5140fa6665622eb6417->name == 'domain' || $v23a5b8ab834cb5140fa6665622eb6417->name == 'lang') {if($v23a5b8ab834cb5140fa6665622eb6417->value === false) return false;}if($v23a5b8ab834cb5140fa6665622eb6417->name == 'domain'){$vea7a5ff9e872aa9554d2d55b11036c30 = $this->selector->hierarchy;if(sizeof($vea7a5ff9e872aa9554d2d55b11036c30) && $vea7a5ff9e872aa9554d2d55b11036c30[0]->elementId) {return false;}}if($v23a5b8ab834cb5140fa6665622eb6417->name == '*') {$this->requireTable('o_asteriks', 'cms3_object_content');$this->requireTable('o', 'cms3_objects');$v724874d1be77f450a09b305fc1534afb = self::getContentTableName($this->selector, null);$v9ab2ec7ea4a2041306f7bdf150fcd453 = array('o_asteriks');if($v724874d1be77f450a09b305fc1534afb != 'cms3_object_content') {$this->requireTable('o_asteriks_branched', $v724874d1be77f450a09b305fc1534afb);$v9ab2ec7ea4a2041306f7bdf150fcd453[] = 'o_asteriks_branched';}$this->queryOptions[] = 'DISTINCT';$vb71a97a0f96cb8b238309d23a188ae98 = array();foreach($v9ab2ec7ea4a2041306f7bdf150fcd453 as $v80071f37861c360a27b7327e132c911a) {$vf09cc7ee3a9a93273f4b80601cafb00c = $v23a5b8ab834cb5140fa6665622eb6417->value;if(!is_array($vf09cc7ee3a9a93273f4b80601cafb00c)) $vf09cc7ee3a9a93273f4b80601cafb00c = array($vf09cc7ee3a9a93273f4b80601cafb00c);$v559cc56c655f21b6412d45a20dabd67d = array();foreach($vf09cc7ee3a9a93273f4b80601cafb00c as $v2063c1608d6e0baf80249c42e2be5804) {$vb29e62a6153f20d910bc9f0d25a57d83 = $this->escapeValue('%' . $v2063c1608d6e0baf80249c42e2be5804 . '%');$v559cc56c655f21b6412d45a20dabd67d[] = $v80071f37861c360a27b7327e132c911a . '.varchar_val LIKE ' . $vb29e62a6153f20d910bc9f0d25a57d83;$v559cc56c655f21b6412d45a20dabd67d[] = $v80071f37861c360a27b7327e132c911a . '.text_val LIKE ' . $vb29e62a6153f20d910bc9f0d25a57d83;$v559cc56c655f21b6412d45a20dabd67d[] = 'o.name LIKE ' . $vb29e62a6153f20d910bc9f0d25a57d83;if(is_numeric($v2063c1608d6e0baf80249c42e2be5804)) {$v559cc56c655f21b6412d45a20dabd67d[] = $v80071f37861c360a27b7327e132c911a . '.float_val = ' . $vb29e62a6153f20d910bc9f0d25a57d83;$v559cc56c655f21b6412d45a20dabd67d[] = $v80071f37861c360a27b7327e132c911a . '.int_val = ' . $vb29e62a6153f20d910bc9f0d25a57d83;}}$vb71a97a0f96cb8b238309d23a188ae98[] = '(' . $v80071f37861c360a27b7327e132c911a . '.obj_id = o.id AND (' . implode(' OR ', $v559cc56c655f21b6412d45a20dabd67d) . '))';}$vac5c74b64b4b8352ef2f181affb5ac2a = '(' . implode(' OR ', $vb71a97a0f96cb8b238309d23a188ae98) . ')';return $vac5c74b64b4b8352ef2f181affb5ac2a;}else {$vb068931cc450442b63f5b3d276ea4297 = $this->requireSysProp($v23a5b8ab834cb5140fa6665622eb6417->name);$vac5c74b64b4b8352ef2f181affb5ac2a = "{$vb068931cc450442b63f5b3d276ea4297}" . $this->parseValue($v23a5b8ab834cb5140fa6665622eb6417->mode, $v23a5b8ab834cb5140fa6665622eb6417->value, $vb068931cc450442b63f5b3d276ea4297);return ($v23a5b8ab834cb5140fa6665622eb6417->mode == 'notequals') ? '('.$vac5c74b64b4b8352ef2f181affb5ac2a.')' : $vac5c74b64b4b8352ef2f181affb5ac2a;}}protected function buildOrder() {$vac5c74b64b4b8352ef2f181affb5ac2a = "";$vb71a97a0f96cb8b238309d23a188ae98 = array();foreach($this->selector->orderFieldProps as $v70a17ffa722a3985b86d30b034ad06d7) {$v945100186b119048837b9859c2c46410 = $v70a17ffa722a3985b86d30b034ad06d7->fieldId;$v1afd32818d1c9525f82aff4c09efd254 = self::getFieldColumn($v945100186b119048837b9859c2c46410);$vb71a97a0f96cb8b238309d23a188ae98[] = "oc_{$v945100186b119048837b9859c2c46410}_lj.{$v1afd32818d1c9525f82aff4c09efd254} " . ($v70a17ffa722a3985b86d30b034ad06d7->asc ? 'ASC' : 'DESC');}foreach($this->selector->orderSysProps as $v70a17ffa722a3985b86d30b034ad06d7) {$vb068931cc450442b63f5b3d276ea4297 = $this->requireSysProp($v70a17ffa722a3985b86d30b034ad06d7->name);$vb71a97a0f96cb8b238309d23a188ae98[] = $vb068931cc450442b63f5b3d276ea4297 . ' ' . ($v70a17ffa722a3985b86d30b034ad06d7->asc ? 'ASC' : 'DESC');}$vac5c74b64b4b8352ef2f181affb5ac2a = implode(', ', $vb71a97a0f96cb8b238309d23a188ae98);return $vac5c74b64b4b8352ef2f181affb5ac2a ? "ORDER BY " . $vac5c74b64b4b8352ef2f181affb5ac2a : "";}protected function buildGroup() {$vac5c74b64b4b8352ef2f181affb5ac2a = "";$vb71a97a0f96cb8b238309d23a188ae98 = array();foreach($this->selector->groupFieldProps as $vdb0f6f37ebeb6ea09489124345af2a45) {$v945100186b119048837b9859c2c46410 = $vdb0f6f37ebeb6ea09489124345af2a45->fieldId;$v1afd32818d1c9525f82aff4c09efd254 = self::getFieldColumn($v945100186b119048837b9859c2c46410);$vb71a97a0f96cb8b238309d23a188ae98[] = "oc_{$v945100186b119048837b9859c2c46410}_lj.{$v1afd32818d1c9525f82aff4c09efd254}";}foreach($this->selector->groupSysProps as $vdb0f6f37ebeb6ea09489124345af2a45) {$vb068931cc450442b63f5b3d276ea4297 = $this->requireSysProp($vdb0f6f37ebeb6ea09489124345af2a45->name);$vb71a97a0f96cb8b238309d23a188ae98[] = $vb068931cc450442b63f5b3d276ea4297;}$vac5c74b64b4b8352ef2f181affb5ac2a = implode(', ', $vb71a97a0f96cb8b238309d23a188ae98);return $vac5c74b64b4b8352ef2f181affb5ac2a ? "GROUP BY " . $vac5c74b64b4b8352ef2f181affb5ac2a : "";}protected function buildPermissions() {$v41275a535677f79ff347e01bc530c176 = $this->selector->permissions;$vb132392a317588e56460e77a8fd74229 = $v41275a535677f79ff347e01bc530c176->owners;if($v41275a535677f79ff347e01bc530c176 && sizeof($vb132392a317588e56460e77a8fd74229)) {$this->requireTable('p', 'cms3_permissions');$this->queryOptions[] = 'DISTINCT';$v92ad7554e2e0d208f33729db6d54b59b = umiObjectsCollection::getInstance()->getObjectIdByGUID('system-guest');if (!in_array($v92ad7554e2e0d208f33729db6d54b59b, $vb132392a317588e56460e77a8fd74229)) $vb132392a317588e56460e77a8fd74229[] = $v92ad7554e2e0d208f33729db6d54b59b;$vb132392a317588e56460e77a8fd74229 = implode(', ', $vb132392a317588e56460e77a8fd74229);return "(p.rel_id = h.id AND p.level & {$v41275a535677f79ff347e01bc530c176->level} AND p.owner_id IN({$vb132392a317588e56460e77a8fd74229}))";}else return "";}protected function buildHierarchy() {$vb81ca7c0ccaa77e7aa91936ab0070695 = $this->selector->hierarchy;if(sizeof($vb81ca7c0ccaa77e7aa91936ab0070695) == 0) return "";$this->requireTable('hr', 'cms3_hierarchy_relations');$vac5c74b64b4b8352ef2f181affb5ac2a = "h.id = hr.child_id AND ";$v032f3ae7c8ab69e3b2d44917fa7b737a = array();foreach($vb81ca7c0ccaa77e7aa91936ab0070695 as $v3f9178c25b78ed8bed19091bcb62e266) {if($v3f9178c25b78ed8bed19091bcb62e266->elementId > 0)     $vdc45f409298a34f384ba3a7ee75a751c = "(hr.level <= {$v3f9178c25b78ed8bed19091bcb62e266->level} AND hr.rel_id";else     $vdc45f409298a34f384ba3a7ee75a751c = "(hr.level < {$v3f9178c25b78ed8bed19091bcb62e266->level} AND hr.rel_id";$vdc45f409298a34f384ba3a7ee75a751c .= ($v3f9178c25b78ed8bed19091bcb62e266->elementId > 0) ? " = '{$v3f9178c25b78ed8bed19091bcb62e266->elementId}'" : " IS NULL";$vdc45f409298a34f384ba3a7ee75a751c .= ")";$v032f3ae7c8ab69e3b2d44917fa7b737a[] = $vdc45f409298a34f384ba3a7ee75a751c;}if (sizeof($v032f3ae7c8ab69e3b2d44917fa7b737a) > 1) $vac5c74b64b4b8352ef2f181affb5ac2a .= "(";$vac5c74b64b4b8352ef2f181affb5ac2a .= implode(' OR ', $v032f3ae7c8ab69e3b2d44917fa7b737a);if (sizeof($v032f3ae7c8ab69e3b2d44917fa7b737a) > 1) $vac5c74b64b4b8352ef2f181affb5ac2a .= ")";return $vac5c74b64b4b8352ef2f181affb5ac2a;}protected static function getFieldColumn($v945100186b119048837b9859c2c46410) {static $v0fea6a13c52b4d4725368f24b045ca84 = array();if(isset($v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410])) return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410];$v06e3d36fa30cea095545139854ad1fb9 = umiFieldsCollection::getInstance()->getField($v945100186b119048837b9859c2c46410);switch($v06e3d36fa30cea095545139854ad1fb9->getDataType()) {case 'string':    case 'password':    case 'tags':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'varchar_val';case 'int':    case 'boolean':    case 'date':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'int_val';case 'counter':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'cnt';case 'price':    case 'float':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'float_val';case 'text':    case 'wysiwyg':    case 'file':    case 'img_file':    case 'swf_file':    case 'video_file':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'text_val';case 'relation':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'rel_val';case 'symlink':     return $v0fea6a13c52b4d4725368f24b045ca84[$v945100186b119048837b9859c2c46410] = 'tree_val';case 'optioned': return false;default:     throw new selectorException("Unsupported field type \"{$v06e3d36fa30cea095545139854ad1fb9->getDataType()}\"");}}protected function escapeValue($v2063c1608d6e0baf80249c42e2be5804) {if(is_array($v2063c1608d6e0baf80249c42e2be5804)) {foreach($v2063c1608d6e0baf80249c42e2be5804 as $v865c0c0b4ab0e063e5caa3387c1a8741 => $v3a6d0284e743dc4a9b86f97d6dd1a3bf) $v2063c1608d6e0baf80249c42e2be5804[$v865c0c0b4ab0e063e5caa3387c1a8741] = $this->escapeValue($v3a6d0284e743dc4a9b86f97d6dd1a3bf);return $v2063c1608d6e0baf80249c42e2be5804;}if ($v2063c1608d6e0baf80249c42e2be5804 instanceof selector) {return $this->escapeValue($v2063c1608d6e0baf80249c42e2be5804->result());}if ($v2063c1608d6e0baf80249c42e2be5804 instanceof iUmiObject || $v2063c1608d6e0baf80249c42e2be5804 instanceof iUmiHierarchyElement) {return $v2063c1608d6e0baf80249c42e2be5804->id;}else {return "'" . l_mysql_real_escape_string($v2063c1608d6e0baf80249c42e2be5804) . "'";}}protected function buildRootQuery($v15d61712450a686a7f365adf4fef581f) {$v5a6f85b0e2c34b7c96af65b0f54b4dea = $this->buildColumns();$vc6c12f4db6ba0426c8e023cb1ca31038 = $this->buildLimit();$va85bfb9c6bcd889ceb433a1c9cd4b218 = $this->buildOrder();$vccc9e74cf27019ed02701010da900d6d = $this->buildWhere();$v75a8be0fca0bc0497c40180b6d02d580 = $this->buildTables();$v39daa41bf389071ad9cd7a7a0ad2ff2c = $this->buildOptions($v15d61712450a686a7f365adf4fef581f);$vd14a8022b085f9ef19d479cbdd581127 = array();foreach($this->selector->types as $v599dcce2998a6b40b1e38e8c6006cb0a) {if($v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType) $vd14a8022b085f9ef19d479cbdd581127[] = $v599dcce2998a6b40b1e38e8c6006cb0a->hierarchyType->getId();}$ve067058f1b6dfcee3ff9b6e52cbada57 = implode(', ', $vd14a8022b085f9ef19d479cbdd581127);$v5a6f85b0e2c34b7c96af65b0f54b4dea = ($v15d61712450a686a7f365adf4fef581f == 'result') ? 'DISTINCT h.id' : 'COUNT(DISTINCT h.id)';$vac5c74b64b4b8352ef2f181affb5ac2a = <<<SQL
SELECT $v5a6f85b0e2c34b7c96af65b0f54b4dea
	FROM cms3_hierarchy hp, {$v75a8be0fca0bc0497c40180b6d02d580}
	{$vccc9e74cf27019ed02701010da900d6d}
	AND (h.rel = 0 OR (h.rel = hp.id AND hp.type_id NOT IN ({$ve067058f1b6dfcee3ff9b6e52cbada57})))
		{$va85bfb9c6bcd889ceb433a1c9cd4b218}
		{$vc6c12f4db6ba0426c8e023cb1ca31038}
SQL;   return $vac5c74b64b4b8352ef2f181affb5ac2a;}protected function excludeNestedPages($vbf516925bb37a8544c8ee19a24e15c05) {$v47c80780ab608cc046f2a6e6f071feb6 = array();foreach ($vbf516925bb37a8544c8ee19a24e15c05 as $vb80bb7740288fda1f201890375a60c8f => $v0db3209e1adc6d67be435a81baf9a66e) {if (!isset($vbf516925bb37a8544c8ee19a24e15c05[$v0db3209e1adc6d67be435a81baf9a66e])) {$v47c80780ab608cc046f2a6e6f071feb6[] = $vb80bb7740288fda1f201890375a60c8f;}}return $v47c80780ab608cc046f2a6e6f071feb6;}};?>
