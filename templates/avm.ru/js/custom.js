jQuery("document").ready(function() {

	jQuery('#delivery_id').change(function() {
		val = $(this).val();
		if(val == 1198) {
			$('#payment_delivery').hide();
			$('#payment_self').show();
		} else {
			$('#payment_self').hide();
			$('#payment_delivery').show();
		}
	});

	var morePhotos = jQuery('.more_photos_container');
	if (morePhotos.length > 0) {
		jQuery(morePhotos).each(function(i, e) {
			var ident = jQuery(e).attr("rel");
			jQuery("a[rel='" + ident + "']").fancybox({
				'titleShow' : false
			});
		});
	}

	jQuery("a[rel='fancy-object']").fancybox({
		'titleShow' : false
	});

	jQuery("#addToCart").live("click", function() {
		jQuery("#addToCartForm").submit();
	});

	jQuery(".colorProperty").live("click", function() {
		
		jQuery(".colorProperty").removeClass("active-color");
		jQuery(this).addClass("active-color");
		var val = jQuery(this).attr("href");
		jQuery("#colorInput").val(val);
		return false;
	});

	jQuery("#filterFormLink").live("click", function() {
		jQuery("#filterForm").submit();
		return false;
	});

	jQuery("input[name=limit],input[name=sort]").change(function() {

		var filtForm = jQuery("#filterForm");
		if (filtForm.length > 0) {
			jQuery(filtForm).submit();
		} else {
			jQuery("#sortForm").submit();
		}
	});

	jQuery("#filterForm").submit(function() {
		var limit = jQuery("input[name=limit]");
		var sort = jQuery("input[name=sort]");

		jQuery(this).append(limit);
		jQuery(this).append(sort);

	});

	jQuery(".addToCartButton,.compareAddToCart").live("click", function() {

		var indProduc = jQuery(this).attr("rel");
		var href = jQuery(this).attr('href');
		addToCartAjax(href, this);
		return false;

	});

	jQuery("#addToCartForm").submit(function() {
		var data = jQuery(this).serialize();
		var act = jQuery(this).attr("action");
		var url = act + '?' + data;

		var btnObj = jQuery("#addToCart");
		addToCartAjax(url, btnObj);
		return false;

	});

	jQuery("input[rel=important]").change(function() {
		
		var propName = jQuery(this).attr("src");
		var dependInput = jQuery("body").find("input[rel=depend][src="+propName+"]");
		var val = jQuery(this).val();
	
		if(dependInput.length >0)
			{
				jQuery(dependInput).each(function(i,e){
					
					 jQuery(e).attr("value","");
					var selfGuide = jQuery(e).attr("href");
					var cuselDiv = jQuery(e).parent();
					
						var getStr =val+'/'+selfGuide+'/'+propName;
						jQuery.ajax({
							url: '/udata/custom/updateSelectContent/'+getStr,
							success: function(xml)
							{
								
								var newHtml = jQuery(xml).find("response").text();
								
								jQuery(cuselDiv).find(".jScrollPaneContainer").attr("style","");
								jQuery(cuselDiv).find(".cusel-scroll-pane").attr("style","");
								jQuery(cuselDiv).find(".cusel-scroll-pane").html(newHtml);
								jQuery(cuselDiv).find(".cuselText").html("Не важно");
								
							}
						})
					
				});
			}
	});
	
	jQuery(".add-to-compare:not(.comparePage)").live("click",function(){
		var self = jQuery(this);
		jQuery.ajax({
			url: jQuery(this).attr("href"),
			success: function(xml)
			{
				var resp = jQuery(xml).find("response").text();
				if(resp == 'unchecked')
					{
						jQuery(self).text("Добавить к сравнению");
					}
				else
					{
						jQuery(self).text("Удалить из сравнения");
					}
			}
		});
		return false;
	});
	
	
	jQuery(".linkSubmit").live("click",function(){
		var idForm = jQuery(this).attr("rel");
		jQuery("#"+idForm).submit();	
		return false;
	});
	
	jQuery(".dispatche-link").live("click",function(){
		var link = jQuery(this).attr("href");
		var act = jQuery(this).attr("rel");
		var selfParent = jQuery(this).parent();
		
		jQuery.ajax({
			url: link,
			success: function(xml)
			{
				if(act=="delete")
					{
					jQuery(selfParent).html('<p class="ib">Вы еще не подписаны на уведомления о спецпредложениях</p><a href="/udata/dispatches/subscribe_custom/" class="ib ml20 dispatche-link">Подписаться</a>'); 
					}
				else
					{
					var dispId = jQuery(xml).find("id").text();
					if(dispId > 0)
						{
						jQuery(selfParent).html('	<p class="ib">Подписан на уведомления о спецпредложениях</p><a href="/udata/dispatches/unsubscribe_custom/'+dispId+'" class="ib ml20 dispatche-link" rel="delete">Отписаться</a>');
						}
					}
			}
		});
		
		return false;
	});
	

	try{
		jQuery("#loginOverlay").overlay({closeOnClick:true});
	}
	catch(e)
	{
		
	}
	
	jQuery("#overlay_arrea").live("click",function(){
		jQuery("#login-form").hide();
		jQuery(this).remove();
	});
	
	jQuery("ul.goods-categories-widget li").hover(function() 
	{
		jQuery(this).find("ul.submenu").hide(); 
		jQuery(this).find('ul').show();
		
	}, function() 
	{
		jQuery(this).find("ul.submenu").hide(); 
	});
		
	
	jQuery('.online-consult-ico a').click(function(){
		$('.webim_button').click();
		return false;
	});

});



function addToCartAjax(url, obj) {
	indProduc = jQuery(obj).attr("rel");
	jQuery.getJSON(url).success(function(rest) {
		var price = rest.summary.price.actual;
		for (key in rest.items.item) {
			if (rest.items.item[key].page.id == indProduc) {
				
				var newCount = rest.items.item[key].amount;
				if(jQuery(obj).hasClass("compareAddToCart"))
				{
					jQuery(obj).html('В корзину ('+ newCount + ')');
				}
				else
				{
					jQuery(obj).html('<img src="/templates/avm.ru/images/bucket-ico.png" class="fl" alt="">&nbsp;Добавить в корзину ('+ newCount + ')');
				}
				
				$.ajax({
                    type: "GET",
                    dataType: 'json',
                    url: "/udata/content/morphWords/"+newCount+'/product/.json',
                    success: function(data) {
						$('.bucket-ico').addClass('fullcart');
						$('.bucket-ico p').html(data.result+' на '+price+' рублей');
                    }
                });
				
			}
		}
	});
}
