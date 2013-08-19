require 'spec_helper'

feature 'Forum authorization' do
  background do
    enrolled_user
  end
end

feature 'Course forum', js: true do
  background do
    enrolled_user
    @forum = FactoryGirl.create(:forum, course: @course)
    @topic = FactoryGirl.create(:topic, forum: @forum)
  end

  scenario 'user creates post in course forum' do
    visit user_root_path
    click_link @course.name
    click_link 'Forums'
    click_link 'Visit Forum'
    click_link @forum.name
    click_link @topic.subject
    fill_in_wysihtml5 'This is a test post.'
    click_button 'Add post'
    page.should have_content('This is a test post')
  end

  scenario 'user creates topic in course forum' do
    visit user_root_path
    click_link @course.name
    click_link 'Forums'
    click_link 'Visit Forum'
    click_link @forum.name
    click_link 'Start new topic'
    fill_in 'Subject', with: 'New Topic 99'
    fill_in_wysihtml5 'Topic body content text.'
    click_button 'Create Forum topic'
    page.should have_content('Topic successfully created')
    page.should have_content('New Topic 99')
    page.should have_content('Topic body content text')
  end
end
