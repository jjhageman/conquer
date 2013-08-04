$(document).ready ->
  $('.tabs a').click (e) ->
    e.preventDefault()
    target = $(this).attr('href')
    $('.tab_area').hide()
    $(this).parent().find('a').removeClass('current')
    $(this).addClass('current')
    $(target).show()