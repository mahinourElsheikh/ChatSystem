FactoryBot.define do
  factory :random_app, class: Application do
    name { Faker::Name.name }
    created_at { DateTime.current.to_s(:db) }
    updated_at { DateTime.current.to_s(:db) }
  end
end