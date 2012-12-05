<?php
	abstract class __auto extends baseModuleAdmin {
		public function config() {
			$regedit = regedit::getInstance();

			$params = array(
				"config" => array(
					"int:per_page" => NULL
				)
			);

			$mode = getRequest("param0");

			if($mode == "do") {
				$params = $this->expectParams($params);
				$regedit->setVar("//modules/auto/per_page", $params['config']['int:per_page']);
				$this->chooseRedirect();
			}

			$params['config']['int:per_page'] = (int) $regedit->getVal("//modules/auto/per_page");

			$this->setDataType("settings");
			$this->setActionType("modify");

			$data = $this->prepareData($params, "settings");

			$this->setData($data);
			return $this->doData();
		}

		public function tree() {
		$regedit = regedit::getInstance();
		
$params['config']['string:На странице'] = (string) $regedit->getVal("//modules/auto/per_page");
 
$this->setDataType("settings");
 $this->setActionType("view");
 
$data = $this->prepareData($params, "settings");
 
$this->setData($data);
return $this->doData();
		}


	};
?>