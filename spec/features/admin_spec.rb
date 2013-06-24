require 'spec_helper'

feature 'Admin' do
  background do
    signed_in_admin
    @course = FactoryGirl.create(:course)
  end

  scenario 'creates new course' do
    visit admin_root_path
    click_link 'New Course'
    fill_in 'Name', with: 'How To Win Friends and Influence People'
    fill_in 'Description', with: "You can go after the job you want...and get it! You can take the job you have...and improve it! You can take any situation you're in...and make it work for you!"
    fill_in 'Price', with: 9.95
    fill_in 'Instructor name', with: 'Dale Carnegie'
    check 'Released'
    click_button 'Create Course'
    page.should have_content('Course successfully created')
  end

  scenario 'creates new forum' do
    visit admin_root_path
    click_link @course.name
    click_link 'New Forum'
    fill_in 'Name', with: 'General Discussion'
    fill_in 'Description', with: 'A place to generally talk about things.'
    click_button 'Create Forum'
    page.should have_content('Forum successfully created')
  end
end
