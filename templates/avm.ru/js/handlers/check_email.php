<?php

include_once '../../../../standalone.php';

$s = new selector('objects');
$s->types('object-type')->name('users', 'user');
$s->where('e-mail')->equals($_REQUEST['email']);
$result = $s->result();
if(is_array($result) && count($result)) {
    echo 'false'; die;
}
echo 'true'; die;

?>
