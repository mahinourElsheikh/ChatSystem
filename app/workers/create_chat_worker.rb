class CreateChatWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'chats'

  def perform(chat, message)
    chat = Chat.new(chat)
    message = Message.new(message)
    chat.save!
    Sidekiq::Client.enqueue_to_in('messages_count', 1.hour.from_now, MessagesCountWorker, chat.id)
    message.chat = chat
    CreateMessageWorker.perform_async(message.as_json)
  end
end
