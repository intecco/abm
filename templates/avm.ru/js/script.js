$(document).ready(function() {
	try {
		$(".slidetabs").tabs(".images > div", {

			// enable "cross-fading" effect
			effect : 'fade',
			fadeOutSpeed : "slow",

			// start from the beginning after the last tab
			rotate : true

		// use the slideshow plugin. It accepts its own configuration
		}).slideshow({

			clickable : false,
			autoplay : true,
			time : 5000
		});

	} catch (e) {

	}
	$(".c1").live("click", function() {
		// $(".sc1").hide();
		$(this).parent().find(".sc1").toggle();
		return false;
	});

	var params = {
		changedEl : ".changeselect"
	}

	cuSel(params);

	//$("a[rel^='prettyPhoto']").prettyPhoto();
	$("a[rel^='prettyPhoto']").prettyPhoto(
        {
            opacity: 0.50,
            default_width: 700,
            default_height: 600,
            theme:'facebook',
	     social_tools:false
    });

	if(typeof window.reloadMark == 'function') {
		reloadMark();
	}

});
