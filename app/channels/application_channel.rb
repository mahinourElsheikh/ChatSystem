class ApplicationChannel < ApplicationCable::Channel
  def subscribed
    stream_from Application.stream_name(params[:token])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
