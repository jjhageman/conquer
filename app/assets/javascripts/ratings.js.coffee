$(document).ready ->
  rating.setupStars()

rating =
  setupStars: ->
    $('.rating_star').click (event) ->
      rating.ajaxSubmit()

  ajaxSubmit: ->
    $.ajax
      url: $('#new_rating').attr('action')
      type: 'POST'
      data: $('#new_rating').serialize()
      dataType: 'json'
      success: (data,status,response) ->
        $('form#enrollment').remove()
      error: (response,textStatus,error) ->
        enrollment.handleAjaxError(response)
