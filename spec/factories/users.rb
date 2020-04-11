FactoryBot.define do
  factory :user do
    name                  {"abe"}
    password              {"0000000"}
    password_confirmation {"0000000"}
    sequence(:email) {Faker::Internet.email}
  end
end