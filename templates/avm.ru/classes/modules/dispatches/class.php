<?php
class dispatches_custom extends def_module {

	public function checkUser()
	{
		$permissions = permissionsCollection::getInstance();
		$obj = umiObjectsCollection::getInstance();

		$userId = $permissions->getUserId();
		$object = $obj->getObject($userId);
		$oSubscriber["id"] = "none";
		if($object instanceof umiObject)
		{
			$sEmail = $object->getValue("e-mail");

			$iSbsHierarchyTypeId = umiHierarchyTypesCollection::getInstance()->getTypeByName("dispatches", "subscriber")->getId();
			$iSbsTypeId = umiObjectTypesCollection::getInstance()->getTypeByHierarchyTypeId($iSbsHierarchyTypeId);
			$oSbsType = umiObjectTypesCollection::getInstance()->getType($iSbsTypeId);

			$oSbsSelection = new umiSelection;
			$oSbsSelection->setObjectTypeFilter();

			$oSbsSelection->addObjectType($iSbsTypeId);
			$oSbsSelection->setNamesFilter();
			$oSbsSelection->addLimit(1);
			$oSbsSelection->addNameFilterEquals($sEmail);
			$arrSbsSelResults = umiSelectionsParser::runSelection($oSbsSelection);

			if (is_array($arrSbsSelResults) && count($arrSbsSelResults)) {
				$iSbsId = $arrSbsSelResults[0];
				$oSubscriber["id"] = $iSbsId;
			}
		}

			
		return $oSubscriber;
	}


	public function unsubscribe_custom($iSbsId=false) {

		if($iSbsId)
			umiObjectsCollection::getInstance()->delObject($iSbsId);
	}

	public function autoSubscribe(umiEventPoint $event) {
		if ($event->getMode() == "after") {
			$user_id  = $event->getParam('user_id');
			$objects = umiObjectsCollection::getInstance();
			$user = $objects->getObject($user_id);
			$email = $user->getValue('e-mail');
			$fname = $user->fname;
			$lname = $user->lname;
			$dispId = $this->checkDisp($user_id);
			if(getRequest("autoSubscribe")) {
				return $subscriber_id = $this->import_subscriber($email, $fname, $lname);
			}

		}
	}

	public function subscribe_custom()
	{
		$retArr["id"] = "";
		$permissions = permissionsCollection::getInstance();
		$user_id=$permissions->getUserId();
		if($user_id)
		{
			$objects = umiObjectsCollection::getInstance();
			$user = $objects->getObject($user_id);
			$email = $user->getValue('e-mail');
			$fname = $user->fname;
			$lname = $user->lname;

			$retArr["id"]= $this->import_subscriber($email, $fname, $lname);
		}
		return $retArr;
	}


};
?>