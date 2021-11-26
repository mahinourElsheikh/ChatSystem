FactoryBot.define do
  factory :random_message, class: Message do
    association :chat, factory: :random_chat
    seq_num { 1 }
    description { 'Test Message' }
    created_at { DateTime.current.to_s(:db) }
    updated_at { DateTime.current.to_s(:db) }
  end
end
