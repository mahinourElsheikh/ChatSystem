class Api::V1::ApplicationsController < Api::ApiController
  # There should be some sort of Authentication maybe cancancan to have certain users with certain abilities to see that
  def index
    applications = Application.all
    json_response(
      { applications: applications.as_json({ only: %i[token chats_count name] }), count: applications.count,
        per_page: per_page, page: page }, :ok
    )
  end

  # POST /applications
  def create
    @app = Application.new(application_params)
    if @app.save
      Sidekiq::Client.enqueue_to_in('chats_count', 1.hour.from_now, ApplicationCountWorker, @app.id)
      json_response({ token: @app.token, name: @app.name }, :ok)
    else
      json_response(nil, :bad_request, @app.errors.full_messages)
    end
  end

  # GET /applications/id
  def show
    @app = Application.find_by(token: params[:id])
    json_response(@app.as_json({ only: %i[token chats_count name] }))
  end

  # PUT /applications/id
  def update
    @app = Application.find_by!(token: params[:id])
    if @app.update(application_params)
      json_response({ token: @app.token, name: @app.name }, :ok)
    else
      json_response(nil, :bad_request, @app.errors.full_messages)
    end
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
