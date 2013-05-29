require 'spec_helper'
include StripeMacro

feature 'User preorders a course', :vcr, js: true do

  background do
    stub_stripe_customer
    @course = FactoryGirl.create(:prereleased_course)
  end

  scenario 'new user successful preorder' do
    visit new_preorder_path(@course)
    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('Congratulations')
    open_email('new@user.com', :with_text => @course.name)
  end

  given(:user) { FactoryGirl.create(:user) }

  scenario 'existing user successful preorder' do
    visit new_preorder_path(@course)
    click_link 'Pre-Order'
    click_link 'Already a member?'
    page.should have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'
    page.should have_content('Payment Information')
    page.should_not have_content('Account Information')

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('Congratulations')
    open_email(user.email, :with_text => @course.name)
  end

  scenario 'existing user attempts to preorder already preordered course' do
    FactoryGirl.create(:enrollment, user: user, course: @course)
    
    visit new_preorder_path(@course)
    click_link 'Pre-Order'
    click_link 'Already a member?'
    page.should have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    page.should have_content("You have already pre-ordered this course")
  end

  scenario 'existing user attempts to preorder already paid for course' do
    FactoryGirl.create(:purchased_enrollment, user: user, course: @course)
    
    visit new_preorder_path(@course)
    click_link 'Pre-Order'
    click_link 'Already a member?'
    page.should have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    page.should_not have_content("Pre-Order")
  end

  given(:promotion) { FactoryGirl.create(:promotion, course: @course) }

  scenario 'user preorders with discount code' do
    visit promotion_path(promotion)
    page.should have_content("$#{promotion.price}")

    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('Congratulations')
    open_email('new@user.com', :with_text => @course.name)
  end
end

feature 'invalid cc', :vcr, js: true do
  background do
    @course = FactoryGirl.create(:prereleased_course)
    stub_invalid_stripe_customer
  end

  scenario 'new user invalid credit card' do
    visit new_preorder_path(@course)
    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4000000000000002'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('There was a problem with your credit card')
  end
end
