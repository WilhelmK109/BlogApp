FactoryBot.define do
  factory :like do
    association :author, factory: :user
    association :post
  end
end
