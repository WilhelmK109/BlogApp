require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(name: 'Christian Momo', photo: nil, bio: nil, posts_counter: 5) }

  before { user.save }

  context 'validations' do
    it 'name should not be empty' do
      user = User.new(name: 'Tom',
                      photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'posts_counter should not be less than 0' do
      user = User.new(name: 'Tom',
                      photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')
      user.posts_counter = -1
      expect(user).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to 0' do
      user = User.new(name: 'Tom',
                      photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')
      user.posts_counter = 3
      expect(user).to be_valid
    end

    it 'posts_counter should be an integer' do
      user = User.new(name: 'Tom',
                      photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')
      user.posts_counter = 'one'
      expect(user).to_not be_valid
    end
  end

  describe '#three_most_recent_posts' do
    before do
      @post1 = user.posts.create(title: 'Post 1', text: 'Hello', comments_counter: 0, likes_counter: 0)
      @post2 = user.posts.create(title: 'Post 2', text: 'Hello', comments_counter: 0, likes_counter: 0)
      @post3 = user.posts.create(title: 'Post 3', text: 'Hello', comments_counter: 0, likes_counter: 0)
      @post4 = user.posts.create(title: 'Post 4', text: 'Hello', comments_counter: 0, likes_counter: 0)
    end

    it 'returns the three most recent posts for a given user' do
      most_recent_posts = user.three_most_recent_posts
      expect(most_recent_posts).to eq([@post4, @post3, @post2])
    end

    it 'returns an empty array if the user has no posts' do
      user.posts.destroy_all
      most_recent_posts = user.three_most_recent_posts
      expect(most_recent_posts).to be_empty
    end
  end
end
