require 'rails_helper'

RSpec.describe 'Posts Workflow', type: :feature do
  let!(:user) { create(:user, posts_counter: 3) }
  let!(:post) { create(:post, author: user) }
  let!(:comments) { create_list(:comment, 2, post:) }
  let!(:likes) { create_list(:like, 2, post:) }

  describe 'User post index page' do
    it "should show the user's profile picture." do
      visit user_posts_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'should see username.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    it 'should see the number of posts the user has written.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.posts_counter)
    end

    it "can see a post's title." do
      visit user_posts_path(user)
      user.posts.limit(3).each do |post|
        expect(page).to have_content(post.title.to_s)
      end
    end

    it "can see some of the post's body." do
      visit user_posts_path(user)
      user.posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see the first comments on a post.' do
      visit user_posts_path(user)
      expect(page).to have_content(comments.first.text)
    end

    it 'can see how many comments a post has.' do
      visit user_post_path(user, post)
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end

    it 'can see how many likes a post has.' do
      visit user_posts_path(user)
      user.posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes.count}")
      end
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
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end
end
