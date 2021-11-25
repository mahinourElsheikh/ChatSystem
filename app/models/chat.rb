class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
  validates :seq_num, uniqueness: { scope: :application }

  def as_json(options = {})
    base = super(options)
    base[:messages] = messages.as_json({ except: %i[id created_at updated_at] }) if messages.present?
    base
  end
end
