$(document).ready ->
  $('.tabs a').click (e) ->
    e.preventDefault()
    target = $(this).attr('href')
    $('.tab_area').hide()
    $(this).parent().find('a').removeClass('current')
    $(this).addClass('current')
    $(target).show()

  $('a.view_chapters').click ->
    $('.other_chapters').slideToggle()
    $('a.view_chapters').text(if $('a.view_chapters').text() == 'Hide Chapters' then 'Show All Chapters' else 'Hide Chapters')
    false
