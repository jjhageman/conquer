module Features
  module SessionHelpers
    def sign_in(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'secret99'
      click_button 'Sign in'
    end

    def sign_up(email, password)
      visit new_user_registration_path
      within('#new-registration') do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
        click_button 'Sign up'
      end
    end
  end
end
