$(document).on('focus keydown click', 'input[data-date-picker]', function () {
  var $input = $(this)
  var format = $input.data('dateTime') ? 'L LT' : 'L'
  var locale = {
    format:      format,
    applyLabel:  $input.data('dateLocaleApply'),
    cancelLabel: $input.data('dateLocaleCancel')
  }
  var options = {
    locale:           locale,
    singleDatePicker: !  $input.data('dateRange'),
    timePicker:       !! $input.data('dateTime'),
    timePicker24Hour: true
  }

  $input
    .daterangepicker(options)
    .removeAttr('data-date-picker')
    .focus()
})
