class CreateChatWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'chats'

  def perform(chat, message)
    chat = Chat.new(chat)
    message = Message.new(message)
    chat.save!
    message.chat = chat
    message.save!
  end
end
