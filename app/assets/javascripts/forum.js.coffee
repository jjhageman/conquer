$(document).ready ->
  #forum.setupForm()

forum =
  setupForm: ->
    $('#forum-post').submit (event) ->
      $('#submitBtn').button('loading')
      $.ajax
        url: $(this).attr('action')
        type: 'POST'
        data: $(this).serialize()
        dataType: 'json'
        success: (data) ->
          $('#forum-posts').append('wenis')
          $('#new-post').remove()
        error: (jxhr, msg, err) ->
          $('#submitBtn').button('reset')
          $('#forum-post').append('error')
      false

