# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { 'Example Post' }
    text { 'This is an example post' }
    comments_counter { 2 }
    likes_counter { 2 }
  end
end
