class ApplicationCountWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'chats_count'

  def perform(application_id)
    application = Application.find_by(id: application_id)
    return unless application.present?  #TODO: should add a bug report why it happened

    application.chats_count = application.chats.count
    application.save
    Sidekiq::Client.enqueue_to_in('chats_count', 1.hour.from_now, ApplicationCountWorker, application.id)
  end
end
