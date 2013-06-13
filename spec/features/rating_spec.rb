require 'spec_helper'

feature 'Course ratings', js: true do

  background do
    enrolled_user
  end
  
  scenario 'user rates course' do
    visit user_root_path
    click_link @course.name
    find(:xpath, "//div[@class='rateit-range']").click
  end
end
