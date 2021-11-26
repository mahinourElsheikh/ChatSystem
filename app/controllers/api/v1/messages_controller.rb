class Api::V1::MessagesController < Api::ApiController
  before_action :set_application_chat
  before_action :set_message, only: %i[update show]
  def index
    messages = @chat.messages.order(seq_num: :desc).paginate(page: page, per_page: per_page)
    json_response({ messages: messages.as_json({ only: %i[seq_num description] }), per_page: per_page, page: page, count: messages.count },
                  :ok)
  end

  # POST /chats/:chat_id/messages
  def create
    message = Message.new(description: params[:message])
    message.seq_num = get_seq_message_number_with_redis(@application.token, @chat.seq_num)
    message.chat = @chat
    if message.valid?
      CreateMessageWorker.perform_async(message.as_json)
      stream_name = Application.stream_name(@application.token)
      ActionCable.server.broadcast stream_name, { chat_seq_id: @chat.seq_num, message: message.as_json }

      json_response({ message: message.as_json({ only: %i[seq_num description] }) }, :ok)
    else
      json_response(nil, :bad_request, 'Something went wrong')
    end
  end

  # GET /chats/:chat_id/messages/:id
  def show
    @message = @chat.messages.find_by(seq_num: params[:id])
    json_response(@message.as_json({ only: %i[seq_num description] }))
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

  def set_message
    @message = @chat.messages.find_by(seq_num: params[:id])
    json_response(nil, :not_found) unless @message.present?
  end
end
