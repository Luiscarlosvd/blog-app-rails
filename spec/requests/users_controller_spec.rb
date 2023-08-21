require './spec/rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #show' do
    it 'renders a successful response' do
      get '/users/show'
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get '/users/show'
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get '/users/show'
      expect(response.body).to include('Here is the description and posts for a given user')
    end
  end

  describe 'GET #index' do
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
      expect(response.body).to include('Here is a list of all users')
    end
  end
end
