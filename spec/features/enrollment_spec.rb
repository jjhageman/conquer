require 'spec_helper'

feature 'Visitor enrolle in a course' do
  background do
    @course = FactoryGirl.create(:course)
  end

  scenario 'new user successful enrollment' do
    visit courses_path
    click_link @course.name
    click_link 'Take Course'
  end
end
