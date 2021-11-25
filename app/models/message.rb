class Message < ApplicationRecord
  belongs_to :chat
  validates :description, presence: true
end
