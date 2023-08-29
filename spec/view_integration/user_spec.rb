require 'rails_helper'

RSpec.describe 'User Workflow', type: :feature do
  let!(:user) { create(:user, name: 'Chikachika', posts_counter: 1, photo: 'http://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Ethiopia') }
  let!(:user2) { create(:user, name: 'Pelepele', posts_counter: 1, photo: 'http://unsplash.com/photos/F_-0BxGuVvo', bio: 'Cook from Zambia') }
  describe 'User index page' do
    it 'displays user information' do
      visit users_path
      expect(page).to have_content(user.name)
      expect(page).to have_selector("img[src='#{user.photo}']")
      expect(page).to have_content(user.posts_counter)
    end

    it 'redirects to user show page when clicking on a user' do
      visit root_path(user)
      click_link("user-name-#{user2.id}")
      expect(page).to have_current_path("/users/#{user2.id}")
    end
  end

  describe 'User show page' do
    it 'displays user information' do
      visit user_path(user)
      expect(page).to have_content(user.name)
      expect(page).to have_selector("img[src='#{user.photo}']")
      expect(page).to have_content(user.bio)
    end

    it 'displays the user\'s first 3 posts' do
      posts = create_list(:post, 3, author: user)
      visit user_path(user)
      posts.each { |post| expect(page).to have_content(post.title) }
    end

    it 'redirects to a post show page when clicking on a user\'s post' do
      post = create(:post, author: user)
      visit user_path(user)
      click_link(post.title)
      expect(page).to have_current_path(user_post_path(user, post.id))
    end

    it 'redirects to user post index page when clicking "View All Posts"' do
      visit user_path(user)
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
