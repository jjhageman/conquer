$(document).ready ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
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
      $('#enrollment')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
