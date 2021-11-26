class Api::V1::SearchController < Api::ApiController
  before_action :set_application_chat

  def search
    @messages = if params[:q].nil?
                  []
                else
                  Message.search(params[:q], @chat.id)
                end
    json_response({ message: @messages.as_json({ except: %i[_id id created_at updated_at chat_id] }) }, :ok)
  end
end
