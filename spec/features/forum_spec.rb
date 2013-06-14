require 'spec_helper'

feature 'Course forum' do
  background do
    enrolled_user
    @forum = FactoryGirl.create(:forum, course: @course)
  end

  scenario 'user creates post in course forum' do
    visit user_root_path
    click_link @course.name
    click_link 'Class Forum'
    click_link @forum.name
  end
end
