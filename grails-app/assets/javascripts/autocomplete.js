/**
 * Created by francois on 15-08-01.
 */
placefound = false;

function initialize() {
    var options = {
        bounds: null,
        //componentRestrictions: {country: 'CA'},
    };
    var input = document.getElementById('pac-place');
    autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        placefound = true;
        var place = this.getPlace();
        $('#lat').val(place.geometry.location.lat());
        $('#lng').val(place.geometry.location.lng());
    });

    $('#form-postcode').on('submit', processForm);
}
window.onload = initialize;

function processForm(e) {
    if (!placefound) {
        alert("Please select a place using the search bar");
        if (e.preventDefault) e.preventDefault();
        return false;
    }
    return true;
}