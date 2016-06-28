function init(){}

var map;

function initMap() {
  window.map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 53.096556, lng:  -3.91907},
    zoom: 6,
    mapTypeControl: false,
    zoomControl: true,
    zoomControlOptions: {
      position: google.maps.ControlPosition.RIGHT_TOP
    },
    scaleControl: true
  });

  var infowindow = new google.maps.InfoWindow();

  events.forEach(function(event) {
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(event.lat, event.lng),
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        strokeColor: 'rgb(239,70,45)',
        scale: 5,
        fillColor: '#ffffff',
        fillOpacity: 1
      },
      map: map
    });

    google.maps.event.addListener(marker, 'click', (function(marker, event) {
      return function() {
        infowindow.setContent(event.description + "<br /><strong>" + event.town + "</strong>") ;
        infowindow.open(map, marker);
      }
    })(marker, event));
  });

  init();
}

function initAutocomplete() {
  var componentForm = {
    administrative_area_level_3: 'town',
    postal_town: 'town',
    locality: 'town',
    country: 'country',
    postal_code: 'postcode',
    street_number: 'house',
    route: 'street',
    administrative_area_level_2: 'region'
  };

  var options = {
    types: ['geocode'],
    componentRestrictions: {country: 'uk'}
  };

  autocomplete = new google.maps.places.Autocomplete( document.getElementById('autocomplete'), options);

  autocomplete.addListener('place_changed', function(){
    var place = autocomplete.getPlace();

    place.address_components.forEach(function(place){
      var addressType = place.types[0],
      formName = componentForm[addressType],
      val = place.long_name,
      field = "#report_" + formName;

      if(val != '') {
        $("#report_" + formName).val(val);
      }
    });

    var loc = autocomplete.getPlace(),
    lat = loc.geometry.location.lat(),
    lng = loc.geometry.location.lng();

    $('#report_lng').val( lng );
    $('#report_lat').val( lat );

    $('.hidden-address').show();
    $('.submit-button').removeClass('disabled').prop('disabled', false);
  });
}

$(function(){
  $('#autocomplete').on('keypress', function(e){
    if(e.keyCode == 13){
      e.preventDefault();
      return false;
    }
  });
});
