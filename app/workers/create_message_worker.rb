class CreateMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'messages'

  def perform(message)
    msg = Message.find_by(id: message['id'])
    if msg.present?
      msg.description = message['description']
    else
      msg = Message.new(message)
    end
    msg.save!
  end
end
