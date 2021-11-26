module Api::Response
  extend ActiveSupport::Concern

  def json_response(object, status = :ok, error_message = nil, options = nil)
    object ||= {}
    object = object.merge(json_errors(error_message)) if error_message.present?
    object = object.merge(options) if options.present?

    render json: object.to_json, status: status
  end

  private

  def json_errors(message)
    return { errors: message } if message.is_a? Array

    { errors: [message] }
  end
end
