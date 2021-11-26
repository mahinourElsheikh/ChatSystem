FactoryBot.define do
  factory :random_chat, class: Chat do
    association :application, factory: :random_app
    seq_num { 1 }
    created_at { DateTime.current.to_s(:db) }
    updated_at { DateTime.current.to_s(:db) }
  end
end