<?php
  $client = new demoClient(array(
    // Код автосалона
    'dealer_id' => 16,
    // Пароль для доступа к данным
   'password'  => 'abm16',
    // Номер используемой версии API
    'api_version' => 1,
    // Путь к каталогу, содержащему XSLT. Путь должен заканчиваться слэшем.
    'xslt_dir'    => $projectDir . '/auto/xslt/',
    /* Путь к каталогу для кэширования. У процесса, выполняющего
       скрипт должны быть права rwx на каталог и его файлы.
       Путь должен заканчиваться слэшем */
    'cache_dir'   => $projectDir.'/auto/cache/',
	'cached_html_themes' => array('marks', 'vehicle')
  ));
?>
