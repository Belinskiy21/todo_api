FactoryBot.define do
  factory :user do
    login { Faker::Internet.email }
    id 1
  end
end
