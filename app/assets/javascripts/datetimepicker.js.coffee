$(document).on 'turbolinks:load', ->
  return unless $('.datepicker').length > 0

  $('.timepicker-meeting').datetimepicker
    lang: 'ru'
    yearStart: new Date().getFullYear()
    yearEnd: new Date().getFullYear() + 1
    dayOfWeekStart: 1
    step: 30
    inline: true

  $('.datepicker-candidate').datetimepicker
    lang: 'ru'
    timepicker: false
    format: 'd.m.Y'
    minDate: '1917/01/01'
    maxDate: 0
    yearStart: 1917
    yearEnd: 2020
