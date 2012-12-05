<?php
class content_custom extends def_module {

	// get slider for main
	public function getSlider()
	{
		$pages = new selector('pages');
		// 109 type of slider pages
		$pages->types('object-type')->id(109);
		$pages->types('hierarchy-type')->name('content', 'page');

		$total =  $pages->length;
		$itemArr = array();
		if($total > 0)
		{
			foreach($pages as $page)
			{
				$tmpArr["attribute:id"] = $page->id;
				$tmpArr["attribute:title"] = $page->getValue("title_slider");
				$tmpArr["node:item"] = $page->getValue("text_slider");
				$itemArr[] = $tmpArr;
			}
		}

		$retArr["items"]["nodes:item"] = $itemArr;
		$retArr["total"] = count($itemArr);
		return $retArr;
	}

	public function getStoreList()
	{
		error_reporting(E_ALL);
		ini_set('display_errors',1);
		
		$pages = new selector('pages');
		
		// 109 type of store pages
		$pages->types('object-type')->id(113);
		$pages->types('hierarchy-type')->name('content', 'page');
		$pages->where('show_in_cart')->isnull(false);
		
		$total =  $pages->length;
		$pages = $pages->result();
		
		$itemArr = array();
		$tmpArr = array();
		if($total > 0)
		{
			foreach($pages as $page)
			{
				$parent = $page->getParentId();
				$tmpArr[$parent][] = $page;
			}
			
			$parents = array();
			foreach($tmpArr as $parent => $values) {
				$parents[] = $parent;
			}
			
			asort($parents);
			$parents_elements = array();
			
			foreach($parents as $parent) {
				$parents_elements[$parent] = $tmpArr[$parent];
			}
			
			foreach($parents_elements as $key=>$arr) {
				$curr["attribute:cat_id"] = $key;
				$curr["nodes:item"] = $arr;
				$retTmpArr[] = $curr;
			}
			
			
		}

		$retArr["nodes:city"] = $retTmpArr;
		$retArr["total"] = $total;
		return $retArr;
	}
	
	public function morphWords($count, $word, $nocount = false) {
        $words = array(
            'product' => array('товар', 'товара', 'товаров'),
        );

        if (array_key_exists($word, $words)) {
            list($first, $second, $third) = $words[$word];

            if ($count == 1) {
                if (!$nocount)
                    $result = '1 ' . $first;
                else
                    $result = $first;
            } elseif (($count > 20) && (($count % 10) == 1)) {
                if (!$nocount)
                    $result = str_replace('%', $count, '% ' . $first);
                else
                    $result = $first;
            } elseif ((($count >= 2) && ($count <= 4)) || ((($count % 10) >= 2) && (($count % 10) <= 4)) && ($count > 20)) {
                if (!$nocount)
                    $result = str_replace('%', $count, '% ' . $second);
                else
                    $result = $second;
            } else {
                if (!$nocount)
                    $result = str_replace('%', $count, '% ' . $third);
                else
                    $result = $third;
            }
            return $result;
        }
    }



};
?>
