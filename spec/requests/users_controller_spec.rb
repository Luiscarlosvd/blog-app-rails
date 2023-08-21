require './spec/rails_helper'

RSpec.describe UsersController, type: :request do
    before(:each) do
      get '/users/show'
    end
    describe "GET #show" do
        it "renders a successful response" do
          expect(response.status).to eq(200)
        end

        it 'renders the show template' do
          expect(response).to render_template('show')
        end

        it 'renders the correct placeholder in the response body' do
          expect(response.body).to include('Here is the description and posts for a given user')
        end
    end
end