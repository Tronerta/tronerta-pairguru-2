FactoryBot.define do
  factory :comment do
    body "MyText"
    movie
    user
  end
end