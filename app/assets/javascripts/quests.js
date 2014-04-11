// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
function initialize() {
	var mapOptions = {
		center: new google.maps.LatLng(6.23623163652871, -75.58052300009876),
		zoom: 17
	};
	var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

	google.maps.event.addListener(map, "click", function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		// populate yor box/field with lat, lng
		$("#quest_latitude").val(lat);
		$("#quest_longitude").val(lng);
	});
}


$(document).ready(function() {

	// Check if a google maps canvas exists and initialize it
	if ($("#map-canvas").length != 0) {
		initialize();
	}

	$('.pic-gallery').magnificPopup({
		delegate: 'a',
		type: 'image',
		gallery: {
			enabled: true
		}
	});
});
