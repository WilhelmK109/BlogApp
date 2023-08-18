require 'rails_helper'

RSpec.describe User, type: :model do
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
