FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    file {"file: credentials"}
    task_id nil
  end
end
