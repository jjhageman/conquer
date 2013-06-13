$(document).ready ->
  rating.setupStars()

rating =
  setupStars: ->
    $('.rateit').bind 'rated reset', (event) ->
      ri = $(this)
      rating_data =
        rating:
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
        $('#rating span').html('Your rating:')
      error: (jxhr, msg, err) ->
        $('.rateit').rateit('readonly', false)
        $('#rating').prepend '<div id="rating-errors" class="alert alert-error fade in">
          <button type="button" class="close" data-dismiss="alert">×</button>'+err+'</div>'
