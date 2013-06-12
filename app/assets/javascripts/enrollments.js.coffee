$(document).ready ->
  #Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  #enrollment.setupForm()

enrollment =
  setupForm: ->
    $('#enrollment').submit (event) ->
      enrollment.clearErrorMessages()
      $('#submitBtn').button('loading')
      enrollment.processCard()
      false
    enrollment.showModalForm() if enrollment.inOrderViewState()

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
      $('#submitBtn').button('reset')

  clearErrorMessages: ->
    $('#enrollment-errors').remove()

  inOrderViewState: ->
    $(location).attr('hash') == '#order'

  showModalForm: ->
    $('#preOrderForm').modal('show')

  isRemoteForm: ->
    $('form#enrollment').data('remote')

  handleAjaxError: (response) ->
    try
      responseText = jQuery.parseJSON(response.responseText)
    catch error
      responseText = null

    msg = if responseText?
      responseText.errors.join('</br>')
    else
       'There was an unknown error or the request timed out.  Please try again later'
 
    $('form#enrollment .modal-body fieldset').prepend '<div id="enrollment-errors" class="alert alert-error fade in">
      <button type="button" class="close" data-dismiss="alert">×</button>'+msg+'</div>'

  ajaxSubmit: ->
    $.ajax
      url: '/enrollments/'
      type: 'POST'
      data: $('#enrollment').serialize()
      dataType: 'json'
      success: (data,status,response) ->
        $('form#enrollment').remove()
        $('#response').show()
      error: (response,textStatus,error) ->
        enrollment.handleAjaxError(response)
        $('#submitBtn').button('reset')
