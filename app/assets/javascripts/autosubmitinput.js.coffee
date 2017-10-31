$(document).on 'turbolinks:load', ->
  return unless $('#user_avatar').length > 0

  $('#user_avatar').on 'change', ->
    this.closest('form').submit()
