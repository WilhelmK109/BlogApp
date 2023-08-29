require 'rails_helper'

RSpec.describe 'Posts Workflow', type: :feature do
  let!(:user) { create(:user, posts_counter: 3) }
  let!(:post) { create(:post, author: user, comments_counter: 2, likes_counter: 2) }

  describe 'User post index page' do
    it 'displays user information, profile picture, and post count' do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'displays post title, body, and comments' do
      visit user_posts_path(user)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content(post.comments_counter)
    end

    it 'redirects to a post show page when clicking on a post' do
      visit user_posts_path(user)
      click_link(post.title)
      expect(page).to have_current_path(user_post_path(user, post))
    end
  end

  describe 'Post show page' do
    it 'displays post information, title, author, author, and comments' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.title)
      expect(page).to have_content(user.name)
      expect(page).to have_content(post.comments_counter)
    end
  end
end
