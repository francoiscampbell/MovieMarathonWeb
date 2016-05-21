/**
 * Created by francois on 2016-05-20.
 */
$(function () {
    var $dateTimePicker = $('#dateTimePicker');
    $dateTimePicker.datetimepicker();

    $dateTimePicker.data("DateTimePicker").options({
        minDate: false,
        format: "DD-MMM-YYYY"
    });
});
