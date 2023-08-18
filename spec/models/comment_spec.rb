require 'rails_helper'

RSpec.describe Comment, type: :model do
  first_user = User.new(name: 'Tom',
                        photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')

  it 'text should not be empty' do
    comment = Comment.new(post: first_post, author: first_user, text: 'Hi Tom!')
    expect(comment).to be_valid
  end
end