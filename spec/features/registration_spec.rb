require 'spec_helper'
include StripeMacro

feature 'Presale course', :vcr, js: true do
  background do
    @course = FactoryGirl.create(:prereleased_course)
  end

  scenario 'new user successfully preorders a course' do
    visit new_enrollment_path(@course)
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

  scenario 'existing user successfully preorders a course' do
    visit new_enrollment_path(@course)
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
    
    visit new_enrollment_path(@course)
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
    
    visit new_enrollment_path(@course)
    click_link 'Pre-Order'
    click_link 'Already a member?'
    page.should have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    page.should_not have_content("Pre-Order")
  end

  scenario 'new user attempts to preorder with invalid email and password' do
    visit new_enrollment_path(@course)
    click_link 'Pre-Order'
    fill_in 'Email', with: 'invalid'
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'short'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('email is invalid')
    page.should have_content('password is too short')
  end

  scenario 'new user attempts to preorder with invalid credit card' do
    visit new_enrollment_path(@course)
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

feature 'Released course', :vcr, js: true do
  background do
    @course = FactoryGirl.create(:course)
  end

  scenario 'new user successfully enrolls in a course' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You are enrolled in: #{@course.name}")
    open_email('new@user.com', :with_text => @course.name)
  end
end
