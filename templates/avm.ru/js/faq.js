jQuery("document").ready(function() {

	jQuery("input[name=catagorySelect]").change(function() {
		var value = jQuery(this).val();
		if (value) {
			jQuery("#faqAjaxContainer").addClass("opacityContent");
			updateConten(value);

		}
	});
	jQuery("input[name=addQestion]").change(function() {
		var value = jQuery(this).val();
		if (value) {
			jQuery("#addFaqQuestion").attr("action",'/faq/post_question/'+value+'/');
		}
	});

	jQuery("#addFaqQuestion").submit(function() {
		var quest = jQuery("#question").val();
		var topic = quest.substr(0, 45);
		jQuery("#topic").val(topic);

	});

	jQuery("#submitQest").click(function() {
		jQuery("#addFaqQuestion").submit();

	});

});

function updateConten(catId) {

	jQuery.ajax({
		url : '/udata/faq/getFaqContent/' + catId,
		success : function(xml) {
			var res = jQuery(xml).find("result").text();
			if (res == 'success') {
				var newContent = jQuery(xml).find("response").text();
				jQuery("#faqAjaxContainer").html(newContent);
			}

			jQuery("#faqAjaxContainer").removeClass("opacityContent");
		},
		error : function() {
			jQuery("#faqAjaxContainer").removeClass("opacityContent");
		}

	});
}
