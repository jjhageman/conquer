require 'spec_helper'
include StripeMacro

feature 'Released course promotional code', :vcr, js: true do
  background do
    stub_stripe_customer
    @course = FactoryGirl.create(:course)
  end

  given(:promotion) { FactoryGirl.create(:promotion, course: @course) }

  scenario 'User purchases a course' do
    visit promotion_path(promotion)
    page.should have_content("$#{promotion.price}")

    click_link 'Take Course'
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Purchase'

    page.should have_content("You're enrolled in #{@course.instructor_name}'s class on #{@course.name}")
    open_email('new@user.com', :with_text => @course.name)
    current_email.default_part_body.to_s.should include(promotion.price.to_s)
  end
end

feature 'Presale course promotional code', :vcr, js: true do
  background do
    stub_stripe_customer
    @course = FactoryGirl.create(:prereleased_course)
  end

  given(:promotion) { FactoryGirl.create(:promotion, course: @course) }

  scenario 'User preorders course' do
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

    page.should have_content("You're confirmed for #{@course.instructor_name}'s class on #{@course.name}")
    open_email('new@user.com', :with_text => @course.name)
  end
end
