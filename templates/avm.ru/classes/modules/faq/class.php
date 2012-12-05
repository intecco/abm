<?php

class faq_custom extends def_module {

	public function getFaqContent($catId=false)
	{
		$retArr["result"] = "error";
		if($catId)
		{
			list($template) = def_module::loadTemplatesForMail("faq/content", "main");
			$param["cat_id"] = $catId;
			$conten = def_module::parseTemplateForMail($template, $param);
			$retArr["result"] = "success";
			$retArr["response"] = $conten;
				
		}
		return $retArr;
	}
}

?>