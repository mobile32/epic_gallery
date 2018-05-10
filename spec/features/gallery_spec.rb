photo = Rails.root + 'spec/fixtures/photo.jpg'

RSpec.feature 'User gallery' do
  context 'with valid data' do
    scenario 'user upload image and want to see it in Images card' do
      sign_in create(:user)
      visit root_path

      within '#navbarNav' do
        click_link_or_button 'Upload images'
      end

      attach_file('upload[files][]', photo)
      click_link_or_button 'Send images'

      expect(page).to have_content 'The image has been uploaded.'
      visit '/images'
      expect(page).to have_css("img[src*='photo.jpg']")
    end

    scenario 'user create new gallery with cover image' do
      sign_in create(:user)
      visit root_path

      within '#navbarNav' do
        click_link_or_button 'Galleries'
      end

      click_link_or_button 'Add new gallery'

      attach_file('gallery[cover_image]', photo)
      fill_in 'Title', with: 'Owls'
      fill_in 'Description', with: 'Gallery with owls'
      click_link_or_button 'Create gallery'

      expect(page).to have_content('The gallery has been created.')
      expect(page).to have_content('Owls')
    end

    scenario 'user upload images with selected gallery' do
      sign_in create(:user)
      visit root_path

      within '#navbarNav' do
        click_link_or_button 'Galleries'
      end

      click_link_or_button 'Add new gallery'
      fill_in 'Title', with: 'Owls'
      click_link_or_button 'Create gallery'

      within '#navbarNav' do
        click_link_or_button 'Upload images'
      end

      attach_file('upload[files][]', photo)

      within '#upload_galleries_ids' do
        find(:xpath, 'option[1]').select_option
      end

      click_link_or_button 'Send images'

      expect(page).to have_content 'The image has been uploaded.'
      expect(page).to have_content 'Owls'
      expect(page).to have_css("div[style*='photo.jpg']")
    end
  end

  context 'with invalid data' do
    scenario 'user try to upload data without images' do
      sign_in create(:user)
      visit root_path

      within '#navbarNav' do
        click_link_or_button 'Upload images'
      end

      click_link_or_button 'Send images'

      expect(page).to have_content 'Upload was failed.'
    end

    scenario 'user create new gallery without title' do
      sign_in create(:user)
      visit root_path

      within '#navbarNav' do
        click_link_or_button 'Galleries'
      end

      click_link_or_button 'Add new gallery'

      attach_file('gallery[cover_image]', photo)
      fill_in 'Title', with: ''
      fill_in 'Description', with: 'Gallery with owls'
      click_link_or_button 'Create gallery'

      expect(page).to have_content("Title can't be blank")
    end
  end
end