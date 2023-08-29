require 'rails_helper'

RSpec.describe 'users/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico',
                  posts_counter: 5)
    end
    let!(:user1) do
      User.create(name: 'Jane Smith', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Colombia',
                  posts_counter: 3)
    end

    before do
      visit users_path
    end

    it 'displays the username of all other users' do
      expect(page).to have_selector('h2', text: 'John Doe')
      expect(page).to have_selector('h2', text: 'Jane Smith')
    end

    it 'displays the profile picture for each user' do
      expect(page).to have_selector('img[alt="User Photo"]', count: 2)
    end

    it 'displays the number of posts each user has written' do
      expect(page).to have_selector('p', text: 'Number of posts: 5')
      expect(page).to have_selector('p', text: 'Number of posts: 3')
    end

    it 'redirects to the user show page' do
      visit users_path
      click_link user.name

      expect(page).to have_current_path(user_path(user))
    end
  end
end
