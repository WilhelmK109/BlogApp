require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    let(:first_user) { User.create(name: 'Tom', photo: 'http://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }

    it 'returns a success response' do
      get user_posts_path(first_user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(first_user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(first_user)
      expect(response.body).to include('All Posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    let(:first_user) { User.create(name: 'Tom', photo: 'http://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:first_post) do
      Post.create(title: 'Example Post', text: 'My first post',
                  comments_counter: 0, likes_counter: 0, author: first_user)
    end

    it 'returns a success response' do
      get user_post_path(first_user, first_post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(first_user, first_post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(first_user, first_post)
      expect(response.body).to include('Post')
    end
  end
end
