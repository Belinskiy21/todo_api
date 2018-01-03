FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    file { Faker::File.file_name }
    task_id nil
  end
end
