FactoryBot.define do
  factory :application do
    name { Faker::Lorem.sentence }
    token { Faker::Config.random.seed }
  end
end