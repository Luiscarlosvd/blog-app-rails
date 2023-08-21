require './spec/rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #show' do
    it 'renders a successful response' do
      get '/users/show/posts/show'
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get '/users/show/posts/show'
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get '/users/show/posts/show'
      expect(response.body).to include('Here is the description and comments of a given post')
    end
  end

  describe 'GET #index' do
    it 'renders a successful response' do
      get '/users/show/posts'
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get '/users/show/posts'
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get '/users/show/posts'
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
end
