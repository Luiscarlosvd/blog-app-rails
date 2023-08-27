require './spec/rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.create(title: 'Post Title', text: 'Post Text', author: user) }
    it 'renders a successful response' do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include('John Doe')
    end
  end

  describe 'GET #index' do
    let!(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher from Mexico', posts_counter: 0) }
    it 'renders a successful response' do
      get '/users'
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get '/users'
      expect(response.body).to include('John Doe')
    end
  end
end
