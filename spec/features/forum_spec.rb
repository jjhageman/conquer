require 'spec_helper'

feature 'Course forum', js: true do
  background do
    enrolled_user
    @forum = FactoryGirl.create(:forum, course: @course)
    @topic = FactoryGirl.create(:topic, forum: @forum)
  end

  scenario 'user creates post in course forum' do
    visit user_root_path
    click_link @course.name
    click_link 'Class Forum'
    click_link @forum.name
    click_link @topic.subject
    #find(:xpath, "/html/body[@class='input-block-level wysihtml5 wysihtml5-editor']").set('This is a test post.')
  end

  scenario 'user creates topic in course forum' do
    visit user_root_path
    click_link @course.name
    click_link 'Class Forum'
    click_link @forum.name
    click_link 'Start new topic'
  end
end
