$(document).on 'turbolinks:load', ->
  return unless $('.bxslider').length > 0

  $('.bxslider').bxSlider
    adaptiveHeight: true
