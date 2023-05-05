FactoryBot.define do
  factory :task do
    title {Faker::Lorem.characters(number:30)}
    body {Faker::Lorem.characters(number:100)}
  end
end