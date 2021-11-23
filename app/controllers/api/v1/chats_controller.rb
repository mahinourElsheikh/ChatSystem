class Api::V1::ChatsController < Api::ApiController
  before_action :set_application
  # require 'sidekiq/redis'
  # There should be some sort of Authentication maybe cancancan to have certain users with certain abilities to see that
  def index
    json_response({ chats: @application.chats.as_json({ except: %i[id] }) },
                  :ok)
  end

  # POST /chats
  def create
    # byebug
    chat = Chat.new
    chat.application = @application
    chat.seq_num = get_seq_number_with_redis(params[:id])
    message = Message.new(description: params[:message])
    message.chat = chat
    if chat.valid? && message.valid?
      CreateChatWorker.perform_async(chat.as_json, message.as_json)
      json_response({ chats: chat.as_json({ except: %i[id] }) }, :ok)
    else
      json_response(nil, :bad_request, 'Something went wrong')
    end
  end

  # GET /applications/id
  def show
    @app = Application.find_by(token: params[:id])
    json_response(@app.as_json({ except: %i[id] }))
  end

  # PUT /applications/id
  def update
    @app = Application.find_by!(token: params[:id])
    if @app.update(application_params)
      json_response({ app_token: @app.token, name: @app.name }, :ok)
    else
      json_response(nil, :bad_request, @app.errors.full_messages)
    end
  end

  private

  def get_seq_number_with_redis(token)
    # # Rails.cache.increment("application_#{token}_chat_sep", 1)
    # Rails.cache.write("application_#{token}_chat_sep", Rails.cache.fetch("application_#{token}_chat_sep").to_i + 1)
    $redis.incr("application_#{token}_chat_sep")
  end

  def set_application
    @application = Application.find_by(token: params[:id])
    json_response(nil, :not_found) unless @application.present?
  end
end
