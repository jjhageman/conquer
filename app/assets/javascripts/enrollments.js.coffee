$(document).ready ->
  #Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  enrollment.setupForm()

enrollment =
  setupForm: ->
    $('#enrollment').submit (event) ->
      $('input[type=submit]').attr('disabled', true)
      enrollment.processCard()
      false

  processCard: ->
    card =
      {number: $('#card_number').val()
      cvc: $('#card_code').val()
      exp_month: $('#card_month').val()
      exp_year: $('#card_year').val()}
    Stripe.createToken(card, enrollment.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#enrollment_stripe_token').val(response.id)
      if enrollment.isRemoteForm()
        enrollment.ajaxSubmit()
      else
        $('#enrollment')[0].submit()
    else
      $('#stripe_error').text(response.error.message).addClass('alert alert-error')
      $('input[type=submit]').attr('disabled', false)

  isRemoteForm: ->
    $('form#enrollment').data('remote')

  handleAjaxError: (response) ->
    try
      responseText = jQuery.parseJSON(response.responseText)
    catch error
      responseText = null

    msg = if responseText?
      JSON.stringify(responseText.errors)
    else
       'There was an unknown error or the request timed out.  Please try again later'

     $('form#enrollment .modal-body fieldset').prepend '<div class="alert alert-error fade in">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <strong>Error: </strong>'+msg+'</div>'

  ajaxSubmit: ->
    $.ajax
      url: '/preorders/'
      type: 'POST'
      data: $('#enrollment').serialize()
      dataType: 'json'
      success: (data,status,response) ->
        $('form#enrollment').remove()
        $('#response').show()
      error: (response,textStatus,error) ->
        enrollment.handleAjaxError(response)
        $('input[type=submit]').attr('disabled', false)
