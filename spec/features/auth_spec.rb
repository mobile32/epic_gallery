RSpec.feature 'User authentication' do
  context 'With valid details' do
    scenario 'sign up' do
      visit '/'
      click_link_or_button 'Sign up'

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change { User.count }.by(1)

      expect(page).to have_content 'Your account has been successfully created'
    end

    scenario 'log into' do
      create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      visit '/'
      click_link_or_button 'Log in'

      expect(current_path).to eq(new_user_session_path)

      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      click_button 'Log in'

      expect(page).to have_content 'Log in successfully'
    end

    scenario 'log out' do
      user = create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      sign_in user
      visit '/'
      click_link_or_button 'Log out'

      expect(page).to have_content 'Log out successfully successfully'
    end
  end

  context 'With invalid details' do
    scenario 'blank fields while sign up' do
      visit '/'
      click_link_or_button 'Sign up'
      click_button 'Create account'

      expect(page).to have_error_messages "First name can't be blank",
                                          "Last name can't be blank",
                                          "Email can't be blank",
                                          "Password can't be blank"

      expect(current_path).to eq(user_registration_path)
    end

    scenario 'not same passwords' do
      visit '/'
      click_link_or_button 'Sign up'

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'xyz'

      expect do
        click_button 'Create account'
      end.to change { User.count }.by(0)

      expect(page).to have_error_message "Password confirmation does not match"
      expect(current_path).to eq(user_registration_path)
    end

    scenario 'already registered email' do
      create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')

      visit '/'
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change { User.count }.by(0)

      expect(page).to have_error_message 'Email has already been taken'
      expect(current_path).to eq(user_registration_path)
    end

    scenario 'invalid email' do
      visit '/'
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski.gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'jkpassword'

      expect do
        click_button 'Create account'
      end.to change { User.count }.by(0)

      expect(page).to have_error_message 'Invalid email address'
      expect(current_path).to eq(user_registration_path)
    end

    scenario 'too short password' do
      min_password_length = 5
      too_short_password = 'p' * (min_password_length - 1)

      visit '/'
      click_link_or_button 'Sign up'

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski.gmail.com'
      fill_in 'Password', with: too_short_password
      fill_in 'Password confirmation', with: too_short_password

      expect(page).to have_error_message 'Password is too short (minimum is 5 characters)'
      expect(current_path).to eq(user_registration_path)
    end
  end
end
