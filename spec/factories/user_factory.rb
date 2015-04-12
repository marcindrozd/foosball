FactoryGirl.define do
  factory :player do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "player#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
