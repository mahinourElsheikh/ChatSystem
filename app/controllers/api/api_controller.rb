class Api::ApiController < ActionController::API
  include Api::ExceptionHandler
  include Api::Response
  include Api::Pagination

  def get_seq_message_number_with_redis(token, chat_seq)
    $redis.incr("application_#{token}_chat_#{chat_seq}sep")
  end

  def get_seq_number_with_redis(token)
    $redis.incr("application_#{token}_chat_sep")
  end
end
