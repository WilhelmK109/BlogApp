FactoryBot.define do
  factory :comment do
    association :author, factory: :user
    association :post
    text { 'This is a comment text.' }
  end
end
