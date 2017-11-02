$(document).on 'turbolinks:load', ->
  return unless $('.datepicker').length > 0

  $('.datepicker').datetimepicker
    lang: 'ru'
    yearStart: new Date().getFullYear()
    yearEnd: new Date().getFullYear() + 1
    dayOfWeekStart: 1
    step: 30
    inline: true
