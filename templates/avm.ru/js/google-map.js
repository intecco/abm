jQuery("document").ready(
		function() {

			var gooleMaps = jQuery('.google-map');
			if (gooleMaps.length > 0) {
				jQuery(gooleMaps).each(
						function(i, e) {

							var ident = jQuery(e).attr("id");
							var id = jQuery(e).attr("rel");
							var lat = jQuery("#latitude_" + id).val();
							var lon = jQuery("#longitude_" + id).val();
						
							if (lat && lon) {
								
							
								var title = jQuery("#google_title_" + id).val();
								var desc = jQuery("#desc_" + id).val();
								
								var myLatlng = new google.maps.LatLng(
										lat, lon);
								var myOptions = {
									zoom : 12,
									center : myLatlng,
									mapTypeControl : false,
									streetViewControl : false,
									mapTypeId : google.maps.MapTypeId.ROADMAP
								};

								var map = new google.maps.Map(document
										.getElementById(ident), myOptions);


								var infowindow = new google.maps.InfoWindow({
									content : desc
								});

								var marker = new google.maps.Marker({
									position : myLatlng,
									title : title
								});

								// To add the marker to the map, call setMap();
								marker.setMap(map);
								google.maps.event.addListener(marker, 'click',
										function() {
											infowindow.open(map, marker);
										});
							}
						});

			}

		});
