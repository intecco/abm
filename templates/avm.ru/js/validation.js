jQuery(document).ready(function(jQuery) {

	jQuery("form").live("submit", function() {

		checkDateField(this);

	});

	$('#authForm').validate({

		rules : {

			"login" : {
				required : true,
				email : true,
				maxlength : 35
			},

			"password" : {
				required : true,
				maxlength : 20,
				minlength : 6

			}
		},

		highlight : function(element, errorClass) {
			$(element).addClass('errorClass');
		},
		showErrors : function(errorMap, errorList) {
			this.defaultShowErrors();
			return true;
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).removeClass('errorClass');
		}
	});

	$('#forgForm').validate({

		rules : {

			"forget_email" : {
				required : true,
				email : true,
				maxlength : 35
			}
		},

		highlight : function(element, errorClass) {
			$(element).addClass('errorClass');
		},
		showErrors : function(errorMap, errorList) {
			this.defaultShowErrors();
			return true;
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).removeClass('errorClass');
		}
	});

	$('#addFaqQuestion').validate({

		rules : {

			"email" : {
				required : true,
				email : true,
				maxlength : 35
			}
		},

		highlight : function(element, errorClass) {
			$(element).addClass('errorClass');
		},
		showErrors : function(errorMap, errorList) {
			this.defaultShowErrors();
			return true;
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).removeClass('errorClass');
		}
	});

	$('#regForm').validate({

		rules : {

			"login" : {
				required : true,
				email : true,
				maxlength : 35
			},

			"password" : {
				required : true,
				maxlength : 20,
				minlength : 6

			},
			"password_confirm" : {
				required : true,
				maxlength : 20,
				minlength : 6,
				equalTo : '#password'
			},
			"email" : {
				required : true,
				email : true,
				maxlength : 35
			}

		},

		highlight : function(element, errorClass) {
			$(element).addClass('errorClass');
		},
		showErrors : function(errorMap, errorList) {
			this.defaultShowErrors();
			$('#errors_overlay').css('display', 'errorClass');
			return true;
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).removeClass('errorClass');
		}
	});
	
	$('#purshForm').validate({
		highlight : function(element, errorClass) {
			$(element).addClass('errorClass');
		},
		showErrors : function(errorMap, errorList) {
			this.defaultShowErrors();
			$('#errors_overlay').css('display', 'errorClass');
			return true;
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).removeClass('errorClass');
		}
	});

	if ($('#mail').length > 0) {
		$("#mail").rules("add", {
			required : true,
			email : true,
			remote : {
				url : "/templates/avm.ru/js/handlers/check_email.php"
			}
		});
	}

});

function checkDateField(form) {
	var dateField = jQuery(form).find(".edit-date");
	if (dateField.length > 0) {
		jQuery(dateField).each(function(i, e) {
			var hidInp = jQuery(e).find('input[type=hidden]');
			if (hidInp.length > 0) {
				var day = jQuery(e).find(".date-day").val();
				var month = jQuery(e).find(".date-month").val();
				var year = jQuery(e).find(".date-year").val();

				jQuery(hidInp).val(day + "/" + month + "/" + year);
			}

		});
	}
}