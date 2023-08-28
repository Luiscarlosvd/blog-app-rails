require 'rails_helper'

RSpec.describe 'posts/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico',
                  posts_counter: 3)
    end
    let!(:user1) do
      User.create(name: 'Jane Smith', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Colombia',
                  posts_counter: 3)
    end
    let!(:post) do
      Post.create(title: 'first post', text: 'first post description', author: user)
    end
    let!(:comment) do
      Comment.create(text: 'first comment', author: user, post:)
    end
    let!(:comment1) do
      Comment.create(text: 'second comment', author: user1, post:)
    end

    before do
      visit user_post_path(user, post)
    end

    it 'displays the username of the selected user and the post title' do
      expect(page).to have_selector('h2', text: 'first post by John Doe')
    end

    it 'displays the number of comments and likes' do
      expect(page).to have_selector('p', text: 'Comments: 2, Likes: 0')
    end

    it 'displays the post body' do
      expect(page).to have_selector('p', text: 'first post description')
    end

    it 'displays the username of each commentor and the text of his comment' do
      expect(page).to have_selector('p', text: 'John Doe: first comment')
      expect(page).to have_selector('p', text: 'Jane Smith: second comment')
    end

    it 'displays the like button' do
      expect(page).to have_button('Like')
    end

    it 'increments the Likes count by one when the Like button is clicked' do
      click_button('Like')

      expect(page).to have_selector('p', text: 'Comments: 2, Likes: 1')
    end

    it 'displays an add a comment link' do
      expect(page).to have_link('Add comment')
    end
  end
end
