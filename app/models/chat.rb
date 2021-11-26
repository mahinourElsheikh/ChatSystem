class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
  validates :seq_num, uniqueness: { scope: :application }

  def as_json(options = {})
    base = super(options)
    base[:messages] = messages.as_json({ only: %i[description seq_num] }) if messages.present?
    base
  end
end
