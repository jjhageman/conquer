class UserMailer < ActionMailer::Base
  default from: "noreply@conquer.com"

  def sign_up_email(user)
    mail to: user.email, subject: 'Welcome to Conquer'
  end

  def purchase_email(user, course)
    @user = user
    @course = course
    mail to: @user.email, subject: 'Successful registration'
  end

  def preorder_email(user, course)
    @user = user
    @course = course
    mail to: @user.email, subject: 'Successful pre-registration'
  end
end
