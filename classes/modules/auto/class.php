<?php

class auto extends def_module {
	public $per_page;

	public function __construct() {
		parent::__construct();

		if(cmsController::getInstance()->getCurrentMode() == "admin") {
			$this->__loadLib("__admin.php");
			$this->__implement("__auto");

			$this->__loadLib("__custom_adm.php");
			$this->__implement("__custom_adm_auto");
		} else {
			$this->per_page = regedit::getInstance()->getVal("//modules/auto/per_page");

			$this->__loadLib("__custom.php");
			$this->__implement("__custom_auto");

			$this->autoDetectAttributes();
		}

		$this->__loadLib("__search.php");
		$this->__implement("__search_auto");

	}


public function category () {
$projectDir = dirname(dirname(__FILE__));
  require_once('Client.php');
Global $client;

  require_once('config.php');
  
Global $_GET;


  $client->setRequest(1);

 $block_arr['infoforallautp']['value'] = $client->getHtml();
 //echo  $block_arr['info'];
//$block_arr['info'] = "ghgg";
		//list($template_block) = self::loadTemplates("auto/".$template, "category");
		
		//echo $block_arr['info'];
		
		return $block_arr['infoforallautp'];
		
		//return self::parseTemplate($template_block, $block_arr);
}

public function detail () {
global $_GET;
$_GET['a'] = getRequest('param0');
$_GET['page'] = getRequest('param0');

$projectDir = dirname(dirname(__FILE__));
  require_once('Client.php');
Global $client;
  require_once('config.php');
  


  $client->setRequest(2);

 $block_arr['infoforallautp']['value'] = $client->getHtml();
 $block_arr['infoforallautp']['value'] = str_replace ('&amp;', '&', $block_arr['infoforallautp']['value']);
 //echo  $block_arr['info'];
//$block_arr['info'] = "ghgg";
		//list($template_block) = self::loadTemplates("auto/".$template, "category");
		
		//echo $block_arr['info'];
		
		return $block_arr['infoforallautp'];
		
		//return self::parseTemplate($template_block, $block_arr);
}

public function getpic ($img_url,$dil,$auto) {

$img_url = str_replace('http%3A/', 'http://', $img_url);
// Обрабатываем превью
$return_img = '';
$projectDir = dirname(dirname(__FILE__));
$img_dir = $projectDir . '/auto/images/';
$imgs_dir = '/classes/modules/auto/images/';
$FileName = $img_url;
$FileName = 'auto_prev_' . $FileName;
if(file_exists($img_dir.$FileName)) {
	$return_img =  $imgs_dir.$FileName;
}
else {
	copy('http://www.maxposter.ru/photo/' . $dil . '/' . $auto . '/original/'.$img_url, $img_dir.$FileName);
	//echo $img_dir.$FileName;
	$return_img =  $imgs_dir.$FileName;
}


//$return_img = '132.jpg';
$block_arr['value'] = $return_img;
return $block_arr;

}



};

?>
