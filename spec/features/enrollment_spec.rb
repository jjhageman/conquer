require 'spec_helper'
include StripeMacro

feature 'Visitor enrolle in a course', :vcr do

  background do
    @course = FactoryGirl.create(:course)
  end
    
  scenario 'new user successful enrollment' do
    stub_stripe_customer

    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    page.should have_content('Create Account')
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'
    click_button 'Sign up'

    page.should have_content("Purchase #{@course.name}")
    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code on Card', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You are enrolled in: #{@course.name}")
  end
end

feature 'invalid cc', vcr: {} do
  background do
    @course = FactoryGirl.create(:course)
  end

  scenario 'new user invalid credit card' do
    stub_invalid_stripe_customer

    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    page.should have_content('Create Account')
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'
    click_button 'Sign up'

    page.should have_content("Purchase #{@course.name}")
    fill_in 'Credit Card Number', with: '4000000000000002'
    fill_in 'Security Code on Card', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content('There was a problem with your credit card')
  end

  scenario 'existing user successful enrollment'
  scenario 'existing user attempts to purchase course they have already bought'
end
