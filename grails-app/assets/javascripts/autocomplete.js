/**
 * Created by francois on 15-08-01.
 */

window.onload = function () {
    var autocompleteOptions = {
        bounds: null
    };
    var pacPlaceInput = document.getElementById('pac-place');
    var autocomplete = new google.maps.places.Autocomplete(pacPlaceInput, autocompleteOptions);
    google.maps.event.addListener(autocomplete, 'place_changed', geocodeAddress);
};

function geocodeAddress() {
    var geocoder = new google.maps.Geocoder();
    var geocodeRequest = {
        address: $('#pac-place').val()
    };
    geocoder.geocode(geocodeRequest, function (geocodeResults, geocodeStatus) {
        if (geocodeStatus === google.maps.GeocoderStatus.OK) {
            var location = geocodeResults[0].geometry.location;
            setLatLng(location.lat(), location.lng());
        } else {
            alert('Please choose a place');
            resetLatLng();
        }
    });
}

function setLatLng(lat, lng) {
    $('#lat').val(lat);
    $('#lng').val(lng);
}

function resetLatLng() {
    $('#lat').val('');
    $('#lng').val('');
}
window.onunload = resetLatLng;