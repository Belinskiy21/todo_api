FactoryBot.define do
  factory :task do
    title { Faker::StarWars.character }
    done false
    deadline '11.12.2018'
    project_id nil
  end
end
