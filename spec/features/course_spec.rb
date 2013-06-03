require 'spec_helper'

feature 'Course access' do

  given(:user) { FactoryGirl.create(:user) }

  scenario 'User tries to enroll in pre-released course' do
    course = FactoryGirl.create(:prereleased_course)

    sign_in user
    visit new_enrollment_path(course)
    page.should have_content('Pre-Order')
  end

  scenario 'User tries to preorder released course' do
    course = FactoryGirl.create(:course)

    sign_in user
    visit new_enrollment_path(course)
    page.should have_content('Your Purchase')
  end
end
