# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { 'Example Post' }
    text { 'This is an example post' }

    after(:create) do |post|
      create_list(:comment, 2, post:)
      create_list(:like, 2, post:)
    end
  end
end
