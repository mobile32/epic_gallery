RSpec.feature 'User gallery' do
  context 'with valid data' do
    scenario 'user upload image and want to see it in Images card' do
      sign_in create(:user)
      visit root_path

      page.find('#navbarNav').click_link_or_button 'Upload images'
      attach_file('upload[files][]', Rails.root + 'spec/fixtures/photo.jpg')
      click_link_or_button 'Send images'

      expect(page).to have_content 'The image has been uploaded.'
      visit '/images'
      expect(page).to have_css("img[src*='photo.jpg']")
    end

    scenario 'user create new gallery with cover image' do
      sign_in create(:user)
      visit root_path

      page.find('#navbarNav').click_link_or_button 'Galleries'
      click_link_or_button 'Add new gallery'

      attach_file('gallery[cover_image]', Rails.root + 'spec/fixtures/photo.jpg')
      fill_in 'Title', with: 'Owls'
      fill_in 'Description', with: 'Gallery with owls'
      click_link_or_button 'Create gallery'

      expect(page).to have_content('The gallery has been created.')
      expect(page).to have_content('Owls')
    end

    scenario 'user upload images with selected gallery' do
      sign_in create(:user)
      visit root_path

      page.find('#navbarNav').click_link_or_button 'Galleries'
      click_link_or_button 'Add new gallery'
      fill_in 'Title', with: 'Owls'
      click_link_or_button 'Create gallery'

      page.find('#navbarNav').click_link_or_button 'Upload images'
      attach_file('upload[files][]', Rails.root + 'spec/fixtures/photo.jpg')
      find('#upload_galleries_ids').find(:xpath, 'option[1]').select_option
      click_link_or_button 'Send images'

      expect(page).to have_content 'The image has been uploaded.'
    end
  end

  context 'with invalid data' do
    scenario 'user upload image and want to see it in Images card' do
      sign_in create(:user)
      visit root_path

      page.find('#navbarNav').click_link_or_button 'Upload images'
      click_link_or_button 'Send images'

      expect(page).to have_content 'Upload was faild.'
    end

    scenario 'user create new gallery without title' do
      sign_in create(:user)
      visit root_path

      page.find('#navbarNav').click_link_or_button 'Galleries'
      click_link_or_button 'Add new gallery'

      attach_file('gallery[cover_image]', Rails.root + 'spec/fixtures/photo.jpg')
      fill_in 'Title', with: ''
      fill_in 'Description', with: 'Gallery with owls'
      click_link_or_button 'Create gallery'

      expect(page).to have_content("Title can't be blank")
    end
  end
end