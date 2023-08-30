require 'rails_helper'

RSpec.describe 'Posts Workflow', type: :feature do
  let!(:user) { create(:user, posts_counter: 3) }
  let!(:post) { create(:post, author: user) }
  let!(:comments) { create_list(:comment, 2, post:) }
  let!(:likes) { create_list(:like, 2, post:) }

  describe 'Post show page' do
    it 'displays post information, title, author, author, and comments' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.title)
      expect(page).to have_content(user.name)
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end
end
