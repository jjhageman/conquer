$(document).ready ->
  $('input[type=file]').bootstrapFileInput()
  $('button#insertImage').click ->
    $('#imageForm').toggle()
