require 'rails_helper'

RSpec.describe 'users/index', type: :system do
  describe 'index page' do
    before do
      User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico',
                  posts_counter: 5)
      User.create(name: 'Jane Smith', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Colombia',
                  posts_counter: 3)

      visit users_path
    end

    it 'displays the username of all other users' do
      expect(page).to have_selector('h2', text: 'John Doe')
      expect(page).to have_selector('h2', text: 'Jane Smith')
    end
  end
end
