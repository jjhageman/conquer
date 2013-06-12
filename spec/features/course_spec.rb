require 'spec_helper'

feature 'Course access' do

  given(:user) { FactoryGirl.create(:user) }

  scenario 'User tries to enroll in pre-released course' do
    course = FactoryGirl.create(:prereleased_course)

    sign_in user
    visit courses_path
    click_link course.name
    page.should have_content('Pre-Order')
  end

  scenario 'User tries to preorder released course' do
    course = FactoryGirl.create(:course)

    sign_in user
    visit courses_path
    click_link course.name
    page.should have_content('Take Course')
  end
end

feature 'Course goes live' do
  scenario 'Pre-ordered users should be charged and receive email notification'
end
