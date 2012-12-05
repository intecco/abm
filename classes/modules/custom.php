<?php
class custom extends def_module {
	public function cms_callMethod($method_name, $args) {
		return call_user_func_array(Array($this, $method_name), $args);
	}

	public function __call($method, $args) {
		throw new publicException("Method " . get_class($this) . "::" . $method . " doesn't exists");
	}

	//return page id, depending on the type of
	public function getPageId($typeId=false,$limit=1)
	{
		$pageArr=array();
		if($typeId)
		{
			$h = umiHierarchy::getInstance();

			$sel = new umiSelection;
			$sel->addHierarchyFilter(0, 10);
			$sel->addObjectType($typeId);
			$sel->setOrderByOrd();
			if($limit)
				$sel->addLimit($limit);

			$ids = umiSelectionsParser::runSelection($sel);
			foreach($ids as $id)
			{
				$currPage = $h->getElement($id);
				if($currPage instanceof umiHierarchyElement)
				{
					$pageArr[] =$currPage;
				}
			}

		}
		$retArr["nodes:page"] = $pageArr;
		return $retArr;
	}

	//get description property
	public function getPropertyHelper($propertyId=false)
	{
		$retArr['type']=array();
		if($propertyId)
		{
			$prop = umiFieldsCollection::getInstance();
			$field   = $prop->getField($propertyId);
			$type = $field->getTip();
			$tmpArr['attribute:name']=$field->getName();
			$tmpArr['node:type']=$type;
			$retArr['type'] = $tmpArr;
		}
		return $retArr;
	}

	// get a reference to guide
	public function getFieldFilterLink($propertyId=false)
	{
		$retArr['guideId']=array();
		if($propertyId)
		{
			$prop = umiFieldsCollection::getInstance();

			$field   = $prop->getField($propertyId);
			$type = $field->getTip();
			if(preg_match("|link_[0-9]+|", $type,$arr))
			{
				$link =@$arr[0];
				if($link)
				{
					$guideId = preg_replace("|[^\d]+|", "", $link);
					if($guideId > 0)
					{
						$retArr['guideId'] = $guideId;
					}
				}
			}
		}
		return $retArr;

	}
	// forman number
	public function formatNumber($number = "") {
		if ($number>0) {
			$number = number_format($number, 2, '.', ' ');
			$number = substr($number, 0, strpos($number, '.'));
		}
		return $number;
	}

	//update cusel(select) block
	public function updateSelectContent($val=false,$guide=false,$prop_name=false)
	{
		$retStr = '<span val="" class="cuselActive">Не важно</span>';
		if($guide && $prop_name)
		{
			$oObjectType = umiObjectTypesCollection::getInstance()->getType($guide);
			$filedId = $oObjectType->getFieldId($prop_name."_guide");

			$sel = new umiSelection;
			$sel->addObjectType($guide);
			if($val)
				$sel->addPropertyFilterEqual($filedId, $val);
			$ids = umiSelectionsParser::runSelection($sel);
			if(count($ids) > 0)
			{
				$obj = umiObjectsCollection::getInstance();

				foreach($ids as $id)
				{
					$objItem = $obj->getObject($id);
					if($objItem instanceof umiObject)
					{
						$retStr.='<span val="'.$id.'">'.$objItem->getName().'</span>';
					}

				}
			}
		}
		$retArr["response"] = $retStr;
		return $retArr;

	}

	// smart resize
	public function getOptimalImageParams($id_elt, $field, $max_width, $max_height) {
		$element = umiHierarchy::getInstance()->getElement($id_elt);
		$type = null; $size = null;
		if($element instanceOf umiHierarchyElement) {
			$image = $element->getValue($field);
			if(is_object($image)) {
				$img_width = $image->getWidth();
				$img_height = $image->getHeight();
				if($img_width >= $img_height) {
					$type = 'width';
					$size = $max_width;
				} else {
					$type = 'height';
					$size = $max_height;
				}
			}
		}

		return array('type' => $type, 'size' => $size);
	}

public function formatPrice($price,$delimeter = ' ') {
		return str_replace(',',$delimeter,number_format($price));
	}

	//TODO: Write your own macroses here
};
?>