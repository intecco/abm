function clearDefValues(target_form)
{
	$(target_form + ' input:text,' + target_form + ' textarea').each(function() {
		if($(this).attr('value') == $(this).val()){
			$(this).val('');
		}
	});
}

function returnDefValues(target_form)
{
	$(target_form + ' input:text,' + target_form + ' textarea').each(function() {
		if($(this).val() == '') {
			$(this).val($(this).attr('value'));
		}
	});
}

$(document).ready(function()
{
	$("form input:text, form textarea").each(function (index) {
		
		if($(this).is('[def]'))
		
		{
			
			var val = $(this).val();
			$(this).attr('value', $(this).attr('def'));
			
			if (val.length > 0) {
				$(this).val(val);
			}
		}
	});

	$("form input:text, form textarea").blur(function () {
		if ($(this).val().length == 0) {
			$(this).val($(this).attr('value'));
		}
	});
    
	$("form input:text, form textarea").focus(function () {
		if ($(this).attr('value') == $(this).attr("def") ) {
			$(this).val('');
		}
	});
});