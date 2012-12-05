<?php
class users_custom extends def_module {
	public function login_error(umiEventPoint $event)
	{
		$this->redirect("/login?error_auth=1");
	}
};

?>
