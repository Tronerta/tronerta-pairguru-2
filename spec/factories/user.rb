FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email {"#{Faker::Lorem.word}@example.com"}
    confirmed_at Time.zone.now
    password "password"
  end
end