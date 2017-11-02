$(document).on 'turbolinks:load', ->
  return unless $('.dropzone').length > 0

  Dropzone.autoDiscover = false

  if $('.dropzone')[0].dropzone
    $('.dropzone')[0].dropzone.destroy()

  $('.dropzone').dropzone
    maxFilesize: 16
    paramName: 'photo[image]'
    addRemoveLinks: false
    acceptedFiles: 'image/*'
    dictDefaultMessage: 'Для загрузки в альбом перетащите сюда файл или нажмите здесь',
    dictFileTooBig: 'Максимальный размер файла 16Мб'
    init: ->
      $('.dz-message').html(this.options.dictDefaultMessage)
      this.on 'success', (file) ->
        this.removeFile file
      this.on 'queuecomplete', ->
        location.reload true
