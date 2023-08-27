require './spec/rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.create(title: 'Post Title', text: 'Post Text', author: user) }

    it 'renders a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Post Title')
    end
  end

  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico', posts_counter: 0) }
    let!(:post) { Post.create(title: 'Post Title', text: 'Post Text', author: user) }
    let!(:post2) { Post.create(title: 'Post Title 2', text: 'Post Text 2', author: user) }

    it 'renders a successful response' do
      get "/users/#{user.id}/posts"
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('John Doe')
    end
  end
end
