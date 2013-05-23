require 'spec_helper'
include StripeMacro

feature 'User preorders a course', :vcr do

  background do
    stub_stripe_customer
    @course = FactoryGirl.create(:course)
  end

  scenario 'new user successful preorder' do
    visit new_preorder_path(@course)
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: 'secret99'
    fill_in 'Password confirmation', with: 'secret99'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select 'January', :from => 'card_month'
    select '2015', :from => 'card_year'
    click_button 'Complete Pre-Order'

    page.should have_content('Congratulations')
  end

  scenario 'existing user successful preorder'
  scenario 'existing user attempts to preorder already preordered course'
  scenario 'user preorders with discount code'
end
