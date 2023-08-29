require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'Index page' do
    let!(:user) do
      User.create(name: 'Matias',
                  photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
                  bio: 'Bio for Matias')
    end

    let!(:post1) do
      Post.create(author_id: user.id, title: 'Post title from Matias Post 1', text: 'Matias Post 1 Text')
    end

    let!(:post2) do
      Post.create(author_id: user.id, title: 'Post title from Matias Post 2', text: 'Matias Post 2 Text')
    end

    let!(:comments) do
      Comment.create(post_id: post1.id, author_id: user.id, text: 'Hi this is some comment!')
      Comment.create(post_id: post1.id, author_id: user.id, text: 'Hi this is some other comment !')
      Comment.create(post_id: post1.id, author_id: user.id, text: 'Hi this is some other comment on post 1')
      Comment.create(post_id: post2.id, author_id: user.id, text: 'Hi this is some comment on post 2')
    end

    let!(:likes) do
      Like.create(post_id: post1.id, author_id: user.id)
      Like.create(post_id: post2.id, author_id: user.id)
      Like.create(post_id: post2.id, author_id: user.id)
    end

    before do
      visit user_posts_path(user)
    end

    it 'displays the username' do
      expect(page).to have_content('Matias')
    end

    it 'shows a post title' do
      expect(page).to have_content('Post title from Matias')
    end

    it 'displays the number of posts for the User' do
      expect(page).to have_selector('p', text: 'Number of posts: 2')
    end

    it 'displays the user profile picture' do
      img_element = find('img[alt="User Photo"]')
      expect(img_element['src']).to eq(user.photo)
    end

    it 'displays part of the post\'s body' do
      expect(page).to have_content(post1.text.truncate_words(25))
      expect(page).to have_content(post2.text.truncate_words(25))
    end

    it 'displays the number of comments and likes for each Post' do
      post1_element = find('.my-3', text: 'Post 1 Text').find(:xpath, '..')
      post2_element = find('.my-3', text: 'Post 2 Text').find(:xpath, '..')
      expect(post1_element).to have_content('Comments: 3, Likes: 1')
      expect(post2_element).to have_content('Comments: 1, Likes: 2')
    end

    it 'displays the first comments on a post' do
      expect(page).to have_content('Hi this is some comment!')
      expect(page).to have_content('Hi this is some other comment !')
      expect(page).to have_content('Hi this is some comment on post 2')
    end

    describe 'redirects to each post when clicked' do
      it 'to post 1 when clicking on post1 link' do
        click_link 'See post', href: user_post_path(user, post1)
        expect(page).to have_current_path(user_post_path(user, post1))
      end
      it 'to post 2 when clicking on post2 link' do
        click_link 'See post', href: user_post_path(user, post2)
        expect(page).to have_current_path(user_post_path(user, post2))
      end
    end

    it 'displays the pagination button' do
      expect(page).to have_css('a', text: 'Pagination')
    end
  end
end
