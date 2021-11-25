class Api::V1::SearchController < Api::ApiController
  before_action :set_application_chat

  def search
    if params[:q].nil?
      @messages = []
    else
      @messages = Message.where(chat_id: params[:chat_id]).search params[:q]
    end
    json_response({ message: @messages.as_json({ except: %i[_id id created_at updated_at] }) }, :ok)
  end
end
