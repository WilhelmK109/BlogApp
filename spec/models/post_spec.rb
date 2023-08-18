require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_user) { User.new(name: 'Tom', photo: nil, bio: nil, posts_counter: 0) }
  let(:first_post) { first_user.posts.create(title: 'Post 1', text: 'Hello', comments_counter: 0, likes_counter: 0) }

  before { first_user.save }

  context 'validations' do
    it 'comments_counter should not be less than 0' do
      first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
      first_post.comments_counter = -3
      expect(first_post).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
      first_post.comments_counter = 'one'
      expect(first_post).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
      first_post.likes_counter = 'one'
      expect(first_post).to_not be_valid
    end
  end

  describe '#five_most_recent_comments' do
    before do
      @comment1 = Comment.create(text: 'comment 1', author: first_user, post: first_post)
      @comment2 = Comment.create(text: 'comment 2', author: first_user, post: first_post)
      @comment3 = Comment.create(text: 'comment 3', author: first_user, post: first_post)
      @comment4 = Comment.create(text: 'comment 4', author: first_user, post: first_post)
      @comment5 = Comment.create(text: 'comment 5', author: first_user, post: first_post)
      @comment6 = Comment.create(text: 'comment 6', author: first_user, post: first_post)
    end

    it 'should return the five most recent comments for a given post' do
      most_recent_comments = first_post.five_most_recent_comments
      expect(most_recent_comments).to eq([@comment6, @comment5, @comment4, @comment3, @comment2])
    end
  end

  describe '#update_author_posts_count' do
    let(:post2) { first_user.posts.build(title: 'Post 2 ', text: 'Hi', comments_counter: 0, likes_counter: 0) }
    it 'Update the author posts_counter after saving' do
      expect do
        post2.save
      end.to change { first_user.reload.posts_counter }.by(1)
    end
  end
end
