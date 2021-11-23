class Message < ApplicationRecord
  belongs_to :chat
  # before_create :generate_token

  private

  # def generate_token
  #   self.token = SecureRandom.urlsafe_base64
  #   generate_token if Application.exists?(token: token)
  # end
end
