/**
 * Created by francois on 15-08-01.
 */

var autocomplete;
var submitReady = false;

window.onload = function () {
    var options = {
        bounds: null
    };
    var input = document.getElementById('pac-place');
    autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        $('#form-postcode').submit();
    });
    $('#form-postcode').submit(processForm);
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
            $('#form-postcode').submit();
        } else {
            alert('Please choose a place');
            resetLatLng();
        }
    });
}

function setLatLng(lat, lng) {
    $('#lat').val(lat);
    $('#lng').val(lng);
    submitReady = true;
}

function resetLatLng() {
    $('#lat').val('');
    $('#lng').val('');
    submitReady = false;
}
window.onunload = resetLatLng;

function processForm() {
    if (submitReady) {
        return true;
    }
    var place = autocomplete.getPlace();
    if (place && place.geometry) {
        var location = place.geometry.location;
        setLatLng(location.lat(), location.lng());
        return true;
    }
    geocodeAddress();
    return false;
}