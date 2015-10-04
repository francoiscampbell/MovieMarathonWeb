/**
 * Created by francois on 2015-10-04.
 */

$(function () {
    $('.movie-container')
        .find('.movie')
        .filter(function (movieIndex, movieElement) {
            return $('#movies')
                .find('option')
                .filter(function (selectIndex, selectElement) {
                    return $(selectElement).prop('value') == $(movieElement).prop('id');
                })
                .prop('selected');
        })
        .addClass('movie-selected');

    $('.movie').click(function () {
        var currentMovie = $(this);
        currentMovie.toggleClass('movie-selected');
        $('#movies')
            .find('option')
            .filter(function (index, element) {
                return $(element).prop('value') == currentMovie.prop('id')
            })
            .prop('selected', function (index, oldProp) {
                return !oldProp; //toggle selection
            })
    });
})
;