<?php
 class umiObjectPropertyCounter extends umiObjectProperty {protected $oldValue;protected function loadValue() {$v9b207167e5381c47682c6b4f58a623fb = Array();$v3aabf39f2d943fa886d86dcbbee4d910 = $this->field_id;$vac5c74b64b4b8352ef2f181affb5ac2a = "SELECT cnt FROM `cms3_object_content_cnt` WHERE obj_id = '{$this->object_id}' AND field_id = '{$v3aabf39f2d943fa886d86dcbbee4d910}' LIMIT 1";$result = l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a, true);if(list($v3a6d0284e743dc4a9b86f97d6dd1a3bf) = mysql_fetch_row($result)) {$v2817f701d5e1a1181e657251363295fd = (int) $v3a6d0284e743dc4a9b86f97d6dd1a3bf;}else {$v2817f701d5e1a1181e657251363295fd = 0;}$this->oldValue = $v2817f701d5e1a1181e657251363295fd;return Array($v2817f701d5e1a1181e657251363295fd);}protected function saveValue() {$v2063c1608d6e0baf80249c42e2be5804 = sizeof($this->value) ? (int) $this->value[0] : 0;$v945f3fc449518a73b9f5f32868db466c = $v2063c1608d6e0baf80249c42e2be5804 - $this->oldValue;if((abs($v945f3fc449518a73b9f5f32868db466c) == 1) && $v2063c1608d6e0baf80249c42e2be5804 !== 0 && $this->oldValue) {$vac5c74b64b4b8352ef2f181affb5ac2a = "UPDATE `cms3_object_content_cnt` SET cnt = cnt + ({$v945f3fc449518a73b9f5f32868db466c}) WHERE obj_id = '{$this->object_id}' AND field_id = '{$this->field_id}'";l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);}else {$this->deleteCurrentRows();$vac5c74b64b4b8352ef2f181affb5ac2a = "INSERT INTO `cms3_object_content_cnt` (obj_id, field_id, cnt) VALUES('{$this->object_id}', '{$this->field_id}', '{$v2063c1608d6e0baf80249c42e2be5804}')";l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);}}protected function deleteCurrentRows() {$v16b2b26000987faccb260b9d39df1269 = (int) $this->object_id;$v945100186b119048837b9859c2c46410 = (int) $this->field_id;$vac5c74b64b4b8352ef2f181affb5ac2a = "DELETE FROM `cms3_object_content_cnt` WHERE `obj_id` = {$v16b2b26000987faccb260b9d39df1269} AND `field_id` = {$v945100186b119048837b9859c2c46410}";l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);}protected function fillNull() {$v16b2b26000987faccb260b9d39df1269 = (int) $this->object_id;$v945100186b119048837b9859c2c46410 = (int) $this->field_id;$vac5c74b64b4b8352ef2f181affb5ac2a = "SELECT COUNT(*) FROM `cms3_object_content_cnt` WHERE `obj_id` = {$v16b2b26000987faccb260b9d39df1269} AND `field_id` = {$v945100186b119048837b9859c2c46410}";$result = l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);list($ve2942a04780e223b215eb8b663cf5353) = mysql_fetch_row($result);if($ve2942a04780e223b215eb8b663cf5353 == 0) {$vac5c74b64b4b8352ef2f181affb5ac2a = "INSERT INTO `cms3_object_content_cnt` (`obj_id`, `field_id`) VALUES ('{$v16b2b26000987faccb260b9d39df1269}', '{$v945100186b119048837b9859c2c46410}')";l_mysql_query($vac5c74b64b4b8352ef2f181affb5ac2a);}}};?>