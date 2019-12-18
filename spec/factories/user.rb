FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email {"user#{rand(10000)}@example.com"}
    confirmed_at Time.zone.now
    password "password"
  end
end