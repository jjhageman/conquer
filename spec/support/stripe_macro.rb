module StripeMacro
  def stub_stripe_customer
    Stripe::Customer.stub(:create).and_return(customer)
  end

  def stub_invalid_stripe_customer
    error = Stripe::CardError.new('Your card was declined', 'card_error', 'card_declined')
    Stripe::Customer.stub(:create).and_raise(error)
  end

  def customer
    return @customer if @customer
    @customer = double 'customer'
    @customer.stub(:id).and_return('cus_1qyHNtGP3pYjQQ')
    @customer.stub(:object).and_return('customer')
    @customer.stub(:created).and_return(1_368_906_576)
    @customer.stub(:livemode).and_return(false)
    @customer.stub(:description).and_return('jjhageman@gmail.com')
    @customer.stub(:active_card).and_return(active_card)
    @customer.stub(:delinquent).and_return(false)
    @customer.stub(:account_balance).and_return(false)
    @customer
  end

  def active_card
    return @active_card if @active_card
    @active_card = double 'active_card'
    @active_card.stub(:object).and_return('card')
    @active_card.stub(:last4).and_return('4242')
    @active_card.stub(:type).and_return('Visa')
    @active_card.stub(:exp_month).and_return(12)
    @active_card.stub(:exp_year).and_return(2013)
    @active_card.stub(:fingerprint).and_return('R4xLb6xtEOSBtN4h')
    @active_card.stub(:country).and_return('US')
    @active_card
  end
end
# #<Stripe::Customer:0x3feb4264aa38> JSON:
# {
#   "id":"cus_1qyHNtGP3pYjQQ",
#   "object":"customer",
#   "created":1368906576,
#   "livemode":false,
#   "description":"jjhageman@gmail.com",
#   "active_card":{
#     "object":"card",
#     "last4":"4242",
#     "type":"Visa",
#     "exp_month":12,
#     "exp_year":2013,
#     "fingerprint":"R4xLb6xtEOSBtN4h",
#     "country":"US",
#     "name":null,
#     "address_line1":null,
#     "address_line2":null,
#     "address_city":null,
#     "address_state":null,
#     "address_zip":null,
#     "address_country":null,
#     "cvc_check":"pass",
#     "address_line1_check":null,
#     "address_zip_check":null
#   },
#   "email":null,
#   "delinquent":false,
#   "subscription":null,
#   "discount":null,
#   "account_balance":0
# }
