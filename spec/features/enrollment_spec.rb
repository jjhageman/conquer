require 'spec_helper'
include StripeMacro

feature 'user enrolls in a course', :vcr do

  background do
    @course = FactoryGirl.create(:course)
    stub_stripe_customer
  end

  scenario 'new user successful enrollment' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    page.should have_content('Create Account')
    within('#new-registration') do
      fill_in 'Email', with: 'new@user.com'
      fill_in 'Password', with: 'secret99'
      fill_in 'Password confirmation', with: 'secret99'
      click_button 'Sign up'
    end

    page.should have_content("Purchase #{@course.name}")
    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code on Card', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You are enrolled in: #{@course.name}")
  end

  given(:user) { FactoryGirl.create(:user) }

  scenario 'existing user successful enrollment' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    within('#new-session') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'secret99'
      click_button 'Sign in'
    end

    page.should have_content("Purchase #{@course.name}")
    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code on Card', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You are enrolled in: #{@course.name}")
  end

  scenario 'existing user attempts to purchase course they have already bought' do
<<<<<<< Updated upstream
    FactoryGirl.create(:purchased_enrollment, user: user, course: @course)
=======
    FactoryGirl.create(:purchased_course, user: user, course: @course)
>>>>>>> Stashed changes

    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    within('#new-session') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'secret99'
      click_button 'Sign in'
    end

    page.should_not have_content("Purchase #{@course.name}")
  end

  scenario 'user preorders with discount code'
end

feature 'invalid cc', vcr: {} do
  background do
    @course = FactoryGirl.create(:course)
    stub_invalid_stripe_customer
  end

  scenario 'new user invalid credit card' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    page.should have_content('Create Account')
    within('#new-registration') do
      fill_in 'Email', with: 'new@user.com'
      fill_in 'Password', with: 'secret99'
      fill_in 'Password confirmation', with: 'secret99'
      click_button 'Sign up'
    end

    page.should have_content("Purchase #{@course.name}")
    fill_in 'Credit Card Number', with: '4000000000000002'
    fill_in 'Security Code on Card', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content('There was a problem with your credit card')
  end
end
