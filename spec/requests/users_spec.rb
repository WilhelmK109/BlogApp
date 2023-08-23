require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('All Users')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { User.create(name: 'Tom', photo: 'http://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }

    it 'returns a success response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('User Profile')
    end
  end
end
