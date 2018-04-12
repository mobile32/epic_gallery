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
      end.to change {User.count}.by(1)

      expect(current_path).to eq '/'
      expect(page).to have_content 'Your account has been successfully created'
    end

    scenario 'log into' do
      create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      visit '/'
      click_link_or_button 'Log in'

      expect(current_path).to eq(new_user_session)

      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      click_button 'Log in' #add more control details

      expect(current_path).to eq '/'
      expect(page).to have_content 'Signed in successfully'
    end

    scenario 'log out' do
      user = create(:user, email: 'jan.kowalski@gmail.com', password: 'jkpassword')
      sign_in user
      visit '/'
      click_link_or_button 'Log out'

      expect(page).to have_content 'Logout successfully'
      expect(current_path).to eq '/'

      click_link_or_button 'Log in'

      expect(current_path).to eq(new_user_session)
    end
  end

  context 'With invalid details' do
    scenario 'blank fields while sign up' do
      expect(page).to have_field('First name', with: '', type: 'text')
      expect(page).to have_field('Last name', with: '', type: 'text')
      expect(page).to have_field('Email', with: '', type: 'email')

      expect(find_field('Password', type: 'password').value).to be_nil
      expect(find_field('Password confirmation', type: 'password').value).to be_nil

      click_button 'Sign up'

      expect(page).to have_error_messages "First name can't be blank",
                                          "Last name can't be blank",
                                          "Email name can't be blank",
                                          "Password can't be blank",
                                          "Password confirmation can't be blank"
    end

    scenario  'not same passwords' do
      visit '/'
      click_link_or_button 'Sign up'

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'First name', with: 'Jan'
      fill_in 'Last name', with: 'Kowalski'
      fill_in 'Email', with: 'jan.kowalski@gmail.com'
      fill_in 'Password', with: 'jkpassword'
      fill_in 'Password confirmation', with: 'xyz'

      click_button 'Create account'

      expect(current_path).to eq(new_user_registration_path)
      expect(page).to have_content "Passwords aren't same"
    end
  end
end
