<?php
		$order = $this->getBasketOrder(false);
		//сохранение регистрационных данных
		$cmsController = cmsController::getInstance();
		$data = $cmsController->getModule('data');
		$data->saveEditedObject(customer::get()->id, false, true);

		$order->refresh();

		$order->order();
		$this->redirect("/order_success/");
	}