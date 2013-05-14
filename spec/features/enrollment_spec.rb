require 'spec_helper'

feature 'Visitor enrolle in a course' do
  scenario 'successful enrollment' do
    visit courses_path
    click_link 'Enroll'
  end
end
