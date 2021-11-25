module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :application_token

    def connect
      self.application_token = find_application
    end

    private

    def find_application
      params = request.query_parameters

      token = params['token']
      application = Application.find_by(token: token)
      if application.present?
        application
      else
        nil
      end
    end
  end
end
