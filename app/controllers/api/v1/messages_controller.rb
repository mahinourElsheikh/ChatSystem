class Api::V1::MessagesController < Api::ApiController
  before_action :set_application_chat
  before_action :set_message, only: %i[update show]
  def index
    json_response({ chats: @chat.messages.as_json({ except: %i[id created_at updated_at] }) }, :ok)
  end

  # POST /chats/:chat_id/messages
  def create
    message = Message.new(description: params[:message])
    message.seq_num = get_seq_message_number_with_redis(@application.token, @chat.seq_num)
    message.chat = @chat
    if message.valid?
      CreateMessageWorker.perform_async(message.as_json)
      json_response({ message: message.as_json({ except: %i[id created_at updated_at] }) }, :ok)
    else
      json_response(nil, :bad_request, 'Something went wrong')
    end
  end

  # GET /chats/:chat_id/messages/:id
  def show
    @message = @chat.messages.find_by(seq_num: params[:id])
    json_response(@message.as_json({ except: %i[id created_at updated_at] }))
  end

  # PUT /chats/:chat_id/messages/:id
  def update
    @message.description = params[:message]
    if @message.valid?
      CreateMessageWorker.perform_async(@message.as_json)
      json_response({ message: @message.as_json }, :ok)
    else
      json_response(nil, :bad_request, 'Something went wrong')
    end
  end

  private

  def set_application_chat
    @application = Application.find_by(token: params[:application_id])
    @chat = @application.chats.find_by(seq_num: params[:chat_id])
    json_response(nil, :not_found) unless @application.present? && @chat.present?
  end

  def set_message
    @message = @chat.messages.find_by(seq_num: params[:id])
    json_response(nil, :not_found) unless @message.present?
  end
end
