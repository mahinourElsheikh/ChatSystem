class Application < ApplicationRecord
  has_many :chats, dependent: :destroy
  before_create :generate_token

  def self.stream_name(token)
    "application_#{token}"
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    generate_token if Application.exists?(token: token)
  end
end
