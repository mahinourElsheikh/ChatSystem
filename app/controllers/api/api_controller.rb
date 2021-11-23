class Api::ApiController < ActionController::API
  include Api::ExceptionHandler
  include Api::Response
  include Api::Pagination

end
