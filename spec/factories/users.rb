# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'Chikachika' }
    posts_counter { 1 }
    photo { 'http://unsplash.com/photos/F_-0BxGuVvo' }
    bio { 'Teacher from Ethiopia' }
  end
end
