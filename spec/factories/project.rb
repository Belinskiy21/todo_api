FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    user_id 1
  end
end
