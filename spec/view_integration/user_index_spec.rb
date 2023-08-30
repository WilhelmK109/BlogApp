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

      expect(page).to have_content(user2.name)
      expect(page).to have_selector("img[src='#{user2.photo}']")
      expect(page).to have_content(user2.posts_counter)
    end

    it 'redirects to user show page when clicking on a user' do
      visit root_path(user)
      click_link(user2.name, href: user_path(user2))
      expect(page).to have_current_path("/users/#{user2.id}")
    end
  end
end
