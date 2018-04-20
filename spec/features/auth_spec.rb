RSpec.feature 'User authentication' do
  context 'with valid details' do
    scenario 'user sings up' do
      visit root_path
      click_link_or_button 'Sign up'

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change {User.count}.by(1)

      expect(page).to have_content 'Your account has been successfully created'
    end

    scenario 'user log into' do
      create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      visit root_path
      click_link_or_button 'Log in'

      expect(current_path).to eq(new_user_session_path)

      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      click_button 'Log in'

      expect(page).to have_content 'Log in successfully'
    end

    scenario 'user log out' do
      user = create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      sign_in user
      visit root_path
      click_link_or_button 'Log out'

      expect(page).to have_content 'Log out successfully successfully'
    end
  end

  context 'with invalid details' do
    scenario 'user lefting blank fields while sign up' do
      visit root_path
      click_link_or_button 'Sign up'
      click_button 'Create account'

      expect(page).to have_error_messages "First name can't be blank",
                                          "Last name can't be blank",
                                          "Email can't be blank",
                                          "Password can't be blank"

      expect(current_path).to eq(user_registration_path)
    end

    scenario 'user filling fields with different passwords' do
      visit root_path
      click_link_or_button 'Sign up'

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'xyz'

      expect do
        click_button 'Create account'
      end.to change {User.count}.by(0)

      expect(page).to have_error_messages "Password confirmation does not match"
      expect(current_path).to eq(user_registration_path)
    end

    scenario 'user trying to register with existing email' do
      create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')

      visit root_path
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change {User.count}.by(0)

      expect(page).to have_error_messages 'Email has already been taken'
      expect(current_path).to eq(user_registration_path)
    end

    scenario 'user using wrong email address' do
      visit root_path
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski.gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change {User.count}.by(0)

      expect(current_path).to eq(user_registration_path)
    end

    scenario 'user using to short password' do
      min_password_length = 5
      too_short_password = 'p' * (min_password_length - 1)

      visit root_path
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@dgmail.com'
      fill_in 'Password', with: too_short_password
      fill_in 'Password confirmation', with: too_short_password

      click_button 'Create account'

      expect(page).to have_error_messages 'Password is too short (minimum is 6 characters)'
      expect(current_path).to eq(user_registration_path)
    end
  end

  context 'with google auth' do
    scenario 'user can login using google oauth2' do
      stub_omniauth
      visit root_path
      click_link_or_button 'Sign up'

      expect(page).to have_link("Sign in with Google")

      click_link "Sign in with Google"

      expect(page).to have_content("Jan Kowalski")
      expect(page).to have_link("Log out")
    end
  end

  context 'With administrator privileges' do
    scenario 'user with admin privileges can open list with users' do
      user = create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword', admin: true)
      sign_in user

      create(:user, email: 'test1@gmail.com', password: 'jkpassword')
      create(:user, email: 'test2@gmail.com', password: 'jkpassword')

      visit '/admin_panel/users'
      expect(current_path).to eq('/admin_panel/users')

      expect(page).to have_content('test1@gmail.com')
      expect(page).to have_content('test2@gmail.com')
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new({
                                   provider: "google",
                                   uid: "12345678910",
                                   info: {
                                       email: "jan.kowalski@dgmail.com",
                                       first_name: "Jan",
                                       last_name: "Kowalski"
                                   },
                                   credentials: {
                                       token: "abcdefg12345",
                                       refresh_token: "12345abcdefg",
                                       expires_at: DateTime.now,
                                   }
                               })
  end
end

