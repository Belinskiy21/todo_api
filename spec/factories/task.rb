FactoryBot.define do
  factory :task do
    title { Faker::StarWars.character }
    done false
    project_id nil
  end
end
