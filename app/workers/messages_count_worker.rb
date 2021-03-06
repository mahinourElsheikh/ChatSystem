class MessagesCountWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'messages_count'

  def perform(chat_id)
    chat = Chat.find_by(id: chat_id)
    return unless chat.present?  #TODO: should add a bug report why it happened

    chat.messages_count = chat.messages&.count
    chat.save
    Sidekiq::Client.enqueue_to_in('messages_count', 1.hour.from_now, MessagesCountWorker, chat.id)
  end
end
