<?php
class catalog_custom extends def_module {

	// get slider for main
	public function getPropertyForMini($pageId=false)
	{
		$tmpArr = array();
		if($pageId)
		{
			$h = umiHierarchy::getInstance();
			$obj = umiObjectsCollection::getInstance();

			$curr = $h->getElement($pageId);
			if($curr instanceof umiHierarchyElement)
			{
				$objPage = $curr->getObject();
				if($objPage instanceof umiObject)
				{
					$type = $objPage->getTypeId();
					$optList = $this->getOptionsPropertyList($type);
					if(is_array($optList) && count($optList) > 0)
					{
						foreach($optList as $prop)
						{
							unset($currProp);
							$propName = @$prop["name"];
							$propVal = $curr->getValue($propName);
							$propType = @$prop["type"];
						
							if($propVal || $propType == "boolean")
							{

								$currProp["attribute:prop_name"] = $propName;
								$currProp["attribute:prop_title"] =@$prop["title"];
								$currProp["attribute:prop_id"] =@$prop["id"];
								if($propType == "relation")
								{
									if(is_array($propVal))
									{
										$objValArr = array();
										foreach($propVal as $objProp)
										{
											$valObj = $obj->getObject($objProp);
											if($valObj instanceof umiObject)
											{
												$objValArr[] = $valObj->getName();
											}
										}
										if(count($objValArr) > 0)
											$currProp["nodes:value_item"] =$objValArr;
									}
									else
									{
										if(intval($propVal) > 0) {
											$prop_obj = $obj->getObject($propVal);
											if(is_object($prop_obj)) {
												$currProp["node:property"] = $prop_obj->getName();
											} else {
												$currProp["node:property"] = $propVal;
											}
										} else {
											$currProp["node:property"] = $propVal;
										}
									}

								}
								else if($propType == "boolean")
								{
									if($propVal)
									{
										$currProp["node:property"] ="есть";
									}
									else
									{
										$currProp["node:property"] ="нет";
									}
								}

								else
								{
									$currProp["node:property"] =$propVal;
								}



								$tmpArr[]= $currProp;
							}
						}
					}

				}
			}
		}

		$retArr["properties"]["nodes:property"] = $tmpArr;
		return $retArr;
	}


	// get options list
	public function getOptionsPropertyList($typeId=false)
	{

		$typeProp = array();

		if($typeId)
		{
			$fg = umiObjectTypesCollection::getInstance();
			$type =$fg->getType($typeId);
			if($type)
			{
				$fileds = $type->getFieldsGroupByName("uniq_property");
				if($fileds)
				{
					$fieldArr = $fileds->getFields();
					$prop = umiFieldsCollection::getInstance();
					foreach($fieldArr as $field)
					{
						unset($_tmpArr);
						$propSort = preg_replace("|[^\d]+|", "", $field->getName());
						if($propSort)
						{
							$fieldId = $field->getId();
							$type = $field->getTip();
							if(preg_match("|mini|", $type))
							{
									
								$propArr["name"] =$field->getName();
								$propArr["id"] = $field->getId();
								$propArr["title"]=$field->getTitle();
								$currTypeProp = $field->getFieldType();
								if($currTypeProp instanceof umiFieldType)
								{
									$propArr["type"] = $currTypeProp->getDataType();
								}

								$typeProp[$propSort]=$propArr;
							}
						}

					}

				}

				ksort($typeProp);
					
					
			}
		}
		return $typeProp;
	}

	public function search_custom($category_id = false, $group_names = "", $template = "default", $type_id = false) {
		if(!$template) $template = "default";

		if($type_id === false) {
			$category_id = $this->analyzeRequiredPath($category_id);
			if(!$category_id) return "";
		}


		list($template_block, $template_block_empty, $template_block_line, $template_block_line_text,
												$template_block_line_relation, $template_block_line_item_relation, $template_block_line_item_relation_separator,
												$template_block_line_price, $template_block_line_boolean, $template_block_line_symlink) =

												def_module::loadTemplates("catalog/".$template, "search_block", "search_block_empty",
																						"search_block_line", "search_block_line_text", "search_block_line_relation",
																						"search_block_line_item_relation", "search_block_line_item_relation_separator",
																						"search_block_line_price", "search_block_line_boolean", "search_block_line_symlink");

		$block_arr = Array();

		if($type_id === false) {
			$type_id = umiHierarchy::getInstance()->getDominantTypeId($category_id);
		}

		if(is_null($type_id)) return "";

		if(!($type = umiObjectTypesCollection::getInstance()->getType($type_id))) {
			trigger_error("Failed to load type", E_USER_WARNING);
			return "";
		}

		$fields = Array();
		$groups = Array();
		$lines = Array();

		$group_names = trim($group_names);
		if($group_names) {
			$group_names_arr = explode(" ", $group_names);
			foreach($group_names_arr as $group_name) {
				if(!($fields_group = $type->getFieldsGroupByName($group_name))) {
				} else {
					$groups[] = $fields_group;
				}
			}
		} else {
			$groups = $type->getFieldsGroupsList();
		}


		$lines_all = Array();
		$groups_arr = Array();

		foreach($groups as $fields_group) {
			$fields = $fields_group->getFields();

			$group_block = Array();
			$group_block['attribute:name'] = $fields_group->getName();
			$group_block['attribute:title'] = $fields_group->getTitle();


			$lines = Array();

			foreach($fields as $field_id => $field) {
				if(!$field->getIsVisible()) continue;
				if(!$field->getIsInFilter()) continue;


					


				$line_arr = Array();

				$field_type_id = $field->getFieldTypeId();
				$field_type = umiFieldTypesCollection::getInstance()->getFieldType($field_type_id);

				$data_type = $field_type->getDataType();
				// Убираем цену из фильтров
				if($data_type=='price')
					continue;

				$line = Array();
				switch($data_type) {
					case "relation": {
						$line = $this->parseSearchRelation($field, $template_block_line_relation, $template_block_line_item_relation, $template_block_line_item_relation_separator);
							$line['attribute:guide_selft'] =$field->getGuideId();
						break;
					}

					case "text": {
						$line = $this->parseSearchText($field, $template_block_line_text);
						break;
					}

					case "date": {
						$line = $this->parseSearchDate($field, $template_block_line_text);
						break;
					}

					case "string": {
						$line = $this->parseSearchText($field, $template_block_line_text);
						break;
					}

					case "wysiwyg": {
						$line = $this->parseSearchText($field, $template_block_line_text);
						break;
					}

					case "float":
					case "price": {
						$line = $this->parseSearchPrice($field, $template_block_line_price);
						break;
					}

					case "int": {
						$line = $this->parseSearchInt($field, $template_block_line_text);
						break;
					}

					case "boolean": {
						$line = $this->parseSearchBoolean($field, $template_block_line_boolean);
						break;
					}

					case "symlink": {
						$line = $this->parseSearchSymlink($field, $template_block_line_symlink, $category_id);
						break;
					}

					default: {
						$line = "[search filter for \"{$data_type}\" not specified]";
						break;
					}
				}

				if (def_module::isXSLTResultMode()) {
					if (is_array($line)) {
						$line['attribute:data-type'] = $data_type;
					}
				}

				$guideLink = $this->getFieldFilterLinkCatalog($field_id);

				if(isset($guideLink["guideId"]))
				{
					$line['attribute:guide_host'] = $guideLink["guideId"];
					if(isset($guideLink["single"]))
					{
						$line['attribute:single'] = 1;
					}

				}

				if(isset($guideLink["important"]))
				{
					$line['attribute:important'] = 1;
				}

				if(isset($guideLink["depend"]))
				{
					$line['attribute:depend'] = 1;
					$line['attribute:depend_filed'] =$guideLink["depend_filed"];
				}

				$line['attribute:id'] = $field_id;
				$line_arr['void:selector'] = $line;

				if (def_module::isXSLTResultMode()) {
					$lines[] = $line;
				} else {
					$lines[] = $tmp = def_module::parseTemplate($template_block_line, $line_arr);
					$lines_all[] = $tmp;
				}
			}


			if(empty($lines)) {
				continue;
			}

			$group_block['nodes:field'] = $lines;
			$groups_arr[] = $group_block;

		}

		$block_arr['void:items'] = $block_arr['void:lines'] = $lines_all;
		$block_arr['nodes:group'] = $groups_arr;
		$block_arr['attribute:category_id'] = $category_id;

		if(!$groups_arr && !$lines && !$this->isXSLTResultMode()) {
			return $template_block_empty;
		}

		return def_module::parseTemplate($template_block, $block_arr);
	}


	public function getFieldFilterLinkCatalog($propertyId=false)
	{
		$retArr=false;
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
						$retArr["guideId"] = $guideId;
					}
				}
			}

			if(preg_match("|link_single_[0-9]+|", $type,$arr))
			{
				$link =@$arr[0];
				if($link)
				{
					$guideId = preg_replace("|[^\d]+|", "", $link);
					if($guideId > 0)
					{
						$retArr["guideId"]= $guideId;
						$retArr["single"]= 1;
					}
				}
			}
				
			if(preg_match("|important|", $type,$arr))
			{
					
				$retArr["important"]= 1;
			}


			if(preg_match("|depend_[a-z0-9_]+|i", $type,$arr))
			{
				$retArr["depend"]= 1;
				$dep_name =@$arr[0];

				if($dep_name!='')
				{
					$dep_name = preg_replace("|depend_|", "", $dep_name);
					if($dep_name!='')
					{
						$retArr["depend_filed"] = $dep_name;
					}
				}

			}
		}
	
		return $retArr;

	}


	public function getObjectsListCustom($template = "default", $path = false, $limit = false, $ignore_paging = false, $i_need_deep = 0, $field_id = false, $asc = true) {
		if(!$template) $template = "default";

		if (!$i_need_deep) $i_need_deep = intval(getRequest('param4'));
		if (!$i_need_deep) $i_need_deep = 0;
		$i_need_deep = intval($i_need_deep);
		if ($i_need_deep === -1) $i_need_deep = 100;

		$hierarchy = umiHierarchy::getInstance();

		list($template_block, $template_block_empty, $template_block_search_empty, $template_line) = def_module::loadTemplates("catalog/".$template, "objects_block", "objects_block_empty", "objects_block_search_empty", "objects_block_line");

		$hierarchy_type_id = umiHierarchyTypesCollection::getInstance()->getTypeByName("catalog", "object")->getId();

		$category_id = $this->analyzeRequiredPath($path);

		if($category_id === false && $path != KEYWORD_GRAB_ALL) {
			throw new publicException(getLabel('error-page-does-not-exist', null, $path));
		}

		$category_element = $hierarchy->getElement($category_id);

		if(!$limit)
		{
			$limit = getRequest("limit");
		}
		$per_page = ($limit) ? $limit : $this->per_page;
		$curr_page = getRequest('p');
		if($ignore_paging) $curr_page = 0;

		$sel = new umiSelection;
		$sel->setElementTypeFilter();
		$sel->addElementType($hierarchy_type_id);

		if($path != KEYWORD_GRAB_ALL) {
			$sel->setHierarchyFilter();
			$sel->addHierarchyFilter($category_id, $i_need_deep);
		}

		$sel->setPermissionsFilter();
		$sel->addPermissions();

		$hierarchy_type = umiHierarchyTypesCollection::getInstance()->getType($hierarchy_type_id);
		$type_id = umiObjectTypesCollection::getInstance()->getBaseType($hierarchy_type->getName(), $hierarchy_type->getExt());


		if($path === KEYWORD_GRAB_ALL) {
			$curr_category_id = cmsController::getInstance()->getCurrentElementId();
		} else {
			$curr_category_id = $category_id;
		}


		if($path != KEYWORD_GRAB_ALL) {
			$type_id = $hierarchy->getDominantTypeId($curr_category_id, $i_need_deep, $hierarchy_type_id);
		}

		if(!$type_id) {
			$type_id = umiObjectTypesCollection::getInstance()->getBaseType($hierarchy_type->getName(), $hierarchy_type->getExt());
		}


		if($type_id) {
			$this->autoDetectOrders($sel, $type_id);
			$this->autoDetectFilters($sel, $type_id);

			if($this->isSelectionFiltered) {
				$template_block_empty = $template_block_search_empty;
				$this->isSelectionFiltered = false;
			}
		} else {
			$sel->setOrderFilter();
			$sel->setOrderByName();
		}

		if($curr_page !== "all") {
			$curr_page = (int) $curr_page;
			$sel->setLimitFilter();
			$sel->addLimit($per_page, $curr_page);
		}

		if(!$field_id)
		{
			$field_id =getRequest("sort");
		}
		if($field_id) {
			if (is_numeric($field_id)) {
				$sel->setOrderByProperty($field_id, $asc);
			} else {
				if ($type_id) {
					$field_id = umiObjectTypesCollection::getInstance()->getType($type_id)->getFieldId($field_id);
					if ($field_id) {
						$sel->setOrderByProperty($field_id, $asc);
					} else {
						$sel ->setOrderByOrd($asc);
					}
				} else {
					$sel ->setOrderByOrd($asc);
				}
			}
		}
		else {
			$sel ->setOrderByOrd($asc);
		}


		$result = umiSelectionsParser::runSelection($sel);
		$total = umiSelectionsParser::runSelectionCounts($sel);

		if(($sz = sizeof($result)) > 0) {
			$block_arr = Array();

			$lines = Array();
			for($i = 0; $i < $sz; $i++) {
				$element_id = $result[$i];
				$element = umiHierarchy::getInstance()->getElement($element_id);

				if(!$element) continue;

				$line_arr = Array();
				$line_arr['attribute:id'] = $element_id;
				$line_arr['attribute:alt_name'] = $element->getAltName();
				$line_arr['attribute:link'] = umiHierarchy::getInstance()->getPathById($element_id);
				$line_arr['xlink:href'] = "upage://" . $element_id;
				$line_arr['node:text'] = $element->getName();

				$lines[] = def_module::parseTemplate($template_line, $line_arr, $element_id);

				$this->pushEditable("catalog", "object", $element_id);
				umiHierarchy::getInstance()->unloadElement($element_id);
			}

			$block_arr['subnodes:lines'] = $lines;
			$block_arr['numpages'] = umiPagenum::generateNumPage($total, $per_page);
			$block_arr['total'] = $total;
			$block_arr['per_page'] = $per_page;
			$block_arr['category_id'] = $category_id;

			if($type_id) {
				$block_arr['type_id'] = $type_id;
			}

			return def_module::parseTemplate($template_block, $block_arr, $category_id);
		} else {
			$block_arr['numpages'] = umiPagenum::generateNumPage(0, 0);
			$block_arr['lines'] = "";
			$block_arr['total'] = 0;
			$block_arr['per_page'] = 0;
			$block_arr['category_id'] = $category_id;

			return def_module::parseTemplate($template_block_empty, $block_arr, $category_id);;
		}

	}


};
?>
