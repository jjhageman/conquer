$(document).ready ->
  rating.setupStars()

rating =
  setupStars: ->
    $('.rateit').bind 'rated reset', (event) ->
      ri = $(this)
      rating_data =
        course_id: ri.data('courseid')
        user_id: ri.data('userid')
        stars: ri.rateit('value')
      ri.rateit('readonly', true)
      rating.ajaxSubmit(rating_data)

  ajaxSubmit: (rtdata) ->
    $.ajax
      url: '/ratings'
      type: 'POST'
      data: rtdata
      dataType: 'json'
      success: (data) ->
        $('#response').append('<li>' + data + '</li>')
      error: (jxhr, msg, err) ->
        $('#response').append('<li style="color:red">' + msg + '</li>')
