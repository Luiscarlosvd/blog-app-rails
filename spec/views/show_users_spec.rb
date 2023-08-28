require 'rails_helper'

RSpec.describe 'users/show', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico',
                  posts_counter: 3)
    end
    let!(:post) do
      Post.create(title: 'first post', text: 'first post description', author: user)
    end
    let!(:post2) do
      Post.create(title: 'second post', text: 'second post description', author: user)
    end
    let!(:post3) do
      Post.create(title: 'third post', text: 'third post description', author: user)
    end

    before do
      visit user_path(user)
    end

    it 'displays the username of the selected user' do
      expect(page).to have_selector('h2', text: 'John Doe')
    end

    it 'displays the profile picture of the user' do
      expect(page).to have_selector('img[alt="User Photo"]', count: 1)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_selector('p', text: 'Number of posts: 3')
    end

    it 'displays the user bio' do
      expect(page).to have_selector('p', text: 'teacher from Mexico')
    end

    it 'displays the users first 3 posts' do
      expect(page).to have_selector('h2', text: 'first post')
      expect(page).to have_selector('h2', text: 'second post')
      expect(page).to have_selector('h2', text: 'third post')
    end

    it 'displays the button to see all posts' do
      expect(page).to have_link('See all posts')
    end

    it 'redirects to the post show page when a user post is clicked' do
      click_link('See post', match: :first)

      expect(page).to have_current_path(user_post_path(user, post3))
    end

    it 'redirects to the post index page when see all post link is clicked' do
      click_link('See all posts')

      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
