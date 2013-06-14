require 'spec_helper'
include StripeMacro

feature 'Presale course', :vcr do
  background do
    stub_stripe_customer
    @course = FactoryGirl.create(:prereleased_course)
  end

  scenario 'new user successfully preorders a course' do
    visit courses_path
    click_link @course.name
    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content("You're confirmed for #{@course.instructor_name}'s class on #{@course.name}")
    unread_emails_for('new@user.com').size.should == 1
    open_email('new@user.com', :with_text => @course.name)
    visit_in_email('Confirm my account and view course')

    fill_in 'Full Name', with: 'Marie-Élise L’Antisémite'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'
    click_button 'Confirm Account'

    current_path.should == course_path(@course)

    click_link 'My Courses'
    page.should have_content(@course.name)
  end

  given(:user) { FactoryGirl.create(:user) }

  scenario 'existing user successfully preorders a course' do
    visit courses_path
    click_link @course.name
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

    page.should have_content("You're confirmed for #{@course.instructor_name}'s class on #{@course.name}")
    unread_emails_for(user.email).size.should == 1
    open_email(user.email, :with_text => @course.name)
    current_email.default_part_body.to_s.should_not include('Confirm my account and view course')
  end

  scenario 'existing user attempts to preorder already preordered course' do
    FactoryGirl.create(:enrollment, user: user, course: @course)
    
    visit courses_path
    click_link @course.name
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
    
    visit courses_path
    click_link @course.name
    click_link 'Pre-Order'
    click_link 'Already a member?'
    page.should have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    page.should_not have_content("Pre-Order")
  end

  scenario 'new user attempts to preorder with invalid email' do
    visit courses_path
    click_link @course.name
    click_link 'Pre-Order'
    fill_in 'Email', with: 'invalid'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('Email is invalid')
  end

  scenario 'new user attempts to preorder with invalid password' do
    visit courses_path
    click_link @course.name
    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content("You're confirmed for #{@course.instructor_name}'s class on #{@course.name}")
    unread_emails_for('new@user.com').size.should == 1
    open_email('new@user.com', :with_text => @course.name)
    visit_in_email('Confirm my account and view course')

    fill_in 'Full Name', with: 'Marie-Élise L’Antisémite'
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'short'
    click_button 'Confirm Account'
    page.should have_content('Password is too short')
  end

  scenario 'new user attempts to preorder with invalid credit card' do
    stub_invalid_stripe_customer
    visit courses_path
    click_link @course.name
    click_link 'Pre-Order'
    fill_in 'Email', with: 'new@user.com'

    fill_in 'Credit Card Number', with: '4000000000000002'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('There was a problem with your credit card')
  end
end

feature 'Released course', :vcr do
  background do
    @course = FactoryGirl.create(:course)
    stub_stripe_customer
  end

  scenario 'new user successfully enrolls in a course' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    fill_in 'Email', with: 'new@user.com'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You're enrolled in #{@course.instructor_name}'s class on #{@course.name}")
    unread_emails_for('new@user.com').size.should == 1
    open_email('new@user.com', :with_text => @course.name)
    visit_in_email('Confirm my account and view course')

    fill_in 'Full Name', with: 'Marie-Élise L’Antisémite'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'
    click_button 'Confirm Account'
    
    current_path.should == user_course_path(@course)
  end

  given(:user) { FactoryGirl.create(:user) }

  scenario 'existing user successfully enrolls in a course' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    click_link 'Already a member?'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You're enrolled in #{@course.instructor_name}'s class on #{@course.name}")
    unread_emails_for(user.email).size.should == 1
    open_email(user.email, :with_text => @course.name)
    current_email.default_part_body.to_s.should_not include('Confirm my account and view course')
    
    click_link 'Go To Class'
  end

  scenario 'existing user attempts to purchase course they have already bought' do
    FactoryGirl.create(:purchased_enrollment, user: user, course: @course)

    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    click_link 'Already a member?'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    current_path.should == user_course_path(@course)
    unread_emails_for(user.email).size.should be_zero
  end

  scenario 'new user attempts to purchase course with invalid credit card' do
    stub_invalid_stripe_customer
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
    click_link 'Already a member?'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret99'
    click_button 'Sign in'

    fill_in 'Credit Card Number', with: '4000000000000002'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content('There was a problem with your credit card')
    unread_emails_for(user.email).size.should be_zero
  end
end
