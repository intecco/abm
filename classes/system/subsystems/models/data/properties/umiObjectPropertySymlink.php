<?php
 class umiObjectPropertySymlink extends umiObjectProperty {protected function loadValue() {$v9b207167e5381c47682c6b4f58a623fb = Array();$v3aabf39f2d943fa886d86dcbbee4d910 = $this->field_id;if($v8d777f385d3dfec8815d20f7496026dc = $this->getPropData()) {foreach($v8d777f385d3dfec8815d20f7496026dc['tree_val'] as $v3a6d0284e743dc4a9b86f97d6dd1a3bf) {if(is_null($v3a6d0284e743dc4a9b86f97d6dd1a3bf)) continue;$v8e2dcfd7e7e24b1ca76c1193f645902b = umiHierarchy::getInstance()->getElement( (int) $v3a6d0284e743dc4a9b86f97d6dd1a3bf );if($v8e2dcfd7e7e24b1ca76c1193f645902b === false) continue;if($v8e2dcfd7e7e24b1ca76c1193f645902b->getIsActive() == false) continue;$v9b207167e5381c47682c6b4f58a623fb[] = $v8e2dcfd7e7e24b1ca76c1193f645902b;}return $v9b207167e5381c47682c6b4f58a623fb;}$vac5c74b64b4b8352ef2f181affb5ac2a = "SELECT  tree_val FROM {$this->tableName} WHERE obj_id = '{$this->object_id}' AND field_id = '{$v3aabf39f2d943fa886d86dcbbee4d910}'";$result = l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a, true);while(list($v3a6d0284e743dc4a9b86f97d6dd1a3bf) = mysql_fetch_row($result)) {if(is_null($v3a6d0284e743dc4a9b86f97d6dd1a3bf)) continue;$v8e2dcfd7e7e24b1ca76c1193f645902b = umiHierarchy::getInstance()->getElement( (int) $v3a6d0284e743dc4a9b86f97d6dd1a3bf );if($v8e2dcfd7e7e24b1ca76c1193f645902b === false) continue;if($v8e2dcfd7e7e24b1ca76c1193f645902b->getIsActive() == false) continue;$v9b207167e5381c47682c6b4f58a623fb[] = $v8e2dcfd7e7e24b1ca76c1193f645902b;}return $v9b207167e5381c47682c6b4f58a623fb;}protected function saveValue() {$this->deleteCurrentRows();$vb81ca7c0ccaa77e7aa91936ab0070695 = umiHierarchy::getInstance();$v2817f701d5e1a1181e657251363295fd = 0;foreach($this->value as $v865c0c0b4ab0e063e5caa3387c1a8741 => $v3a6d0284e743dc4a9b86f97d6dd1a3bf) {if($v3a6d0284e743dc4a9b86f97d6dd1a3bf === false || $v3a6d0284e743dc4a9b86f97d6dd1a3bf === "") continue;if(is_object($v3a6d0284e743dc4a9b86f97d6dd1a3bf)) {$v3a6d0284e743dc4a9b86f97d6dd1a3bf = (int) $v3a6d0284e743dc4a9b86f97d6dd1a3bf->getId();}else {$v3a6d0284e743dc4a9b86f97d6dd1a3bf = intval($v3a6d0284e743dc4a9b86f97d6dd1a3bf);}if(!$v3a6d0284e743dc4a9b86f97d6dd1a3bf) continue;if(is_numeric($v3a6d0284e743dc4a9b86f97d6dd1a3bf)) {$v3a6d0284e743dc4a9b86f97d6dd1a3bf = (int) $v3a6d0284e743dc4a9b86f97d6dd1a3bf;$this->value[$v865c0c0b4ab0e063e5caa3387c1a8741] = $vb81ca7c0ccaa77e7aa91936ab0070695->getElement($v3a6d0284e743dc4a9b86f97d6dd1a3bf);}$vac5c74b64b4b8352ef2f181affb5ac2a = "INSERT INTO {$this->tableName} (obj_id, field_id, tree_val) VALUES('{$this->object_id}', '{$this->field_id}', '{$v3a6d0284e743dc4a9b86f97d6dd1a3bf}')";l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);++$v2817f701d5e1a1181e657251363295fd;}if(!$v2817f701d5e1a1181e657251363295fd) {$this->fillNull();}}};?>