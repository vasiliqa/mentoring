$(document).on 'turbolinks:load', ->
  return unless $('select.dropdown').length > 0

  $('select.dropdown').dropdown()
