class UserMailer < ActionMailer::Base
  default from: 'noreply@conquer.com'

  def sign_up_email(user)
    mail to: user.email, subject: 'Welcome to Conquer'
  end

  def purchase_email(user, course, price)
    @user = user
    @course = course
    @price = price
    mail to: @user.email, subject: 'Successful registration'
  end

  def confirmation_and_purchase_email(user, course, price)
    @user = user
    @course = course
    @price = price
    mail to: @user.email, subject: 'Successful registration'
  end
end
