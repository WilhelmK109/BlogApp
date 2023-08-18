require 'rails_helper'

RSpec.describe Post, type: :model do
  first_user = User.new(name: 'Tom',
                        photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

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