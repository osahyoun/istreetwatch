function init(){

}

function initAutocomplete() {

  var componentForm = { postal_town: 'town',
    country: 'country',
    postal_code: 'postcode',
    street_number: 'house',
    route: 'street',
    administrative_area_level_2: 'region'
  };

  autocomplete = new google.maps.places.Autocomplete( document.getElementById('autocomplete'), {types: ['geocode']});

  autocomplete.addListener('place_changed', function(){
    var place = autocomplete.getPlace();


    place.address_components.forEach(function(place){
      var addressType = place.types[0];
      var formName = componentForm[addressType];
      var val = place.long_name;
      var field = "#report_" + formName;
      $("#report_" + formName).val(val);
    });

    var loc = autocomplete.getPlace(),
    lat = loc.geometry.location.lat(),
    lng = loc.geometry.location.lng();

    $('#report_lng').val( lng );
    $('#report_lat').val( lat );

    var myLatLng = {lat: lat, lng: lng};
    new google.maps.Marker({
      position: myLatLng,
      map: window.map,
      title: 'Hello World!'
    });

  })
}


