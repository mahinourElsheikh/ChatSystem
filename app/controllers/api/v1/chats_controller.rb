class Api::V1::ChatsController < Api::ApiController
  before_action :set_application

  def index
    json_response(
      { chats: @application.chats.order(seq_num: :desc).as_json({ except: %i[id created_at updated_at] }) }, :ok
    )
  end

  def create
    chat = Chat.new
    chat.application = @application
    chat.seq_num = get_seq_number_with_redis(params[:application_id])
    chat.messages_count = 1
    message = Message.new(description: params[:message])
    message.seq_num = get_seq_message_number_with_redis(params[:application_id], chat.seq_num)
    message.chat = chat
    if chat.valid? && message.valid?
      CreateChatWorker.perform_async(chat.as_json, message.as_json)
      stream_name = Application.stream_name(@application.token)
      ActionCable.server.broadcast stream_name, { chat_seq_id: chat.seq_num, message: message.as_json }

      json_response({ chats: chat.as_json({ except: %i[id created_at updated_at], include: %i[messages] }) }, :ok)
    else
      json_response(nil, :bad_request, 'Something went wrong')
    end
  end

  def show
    @chat = @application.chats.where(seq_num: params[:id])
    return json_response(nil, :not_found) unless @application.present?

    json_response(@chat.as_json({ except: %i[id created_at updated_at] }))
  end

  private

  def set_application
    @application = Application.find_by(token: params[:application_id])
    json_response(nil, :not_found) unless @application.present?
  end
end
