class NotificationChannel < ApplicationCable::Channel
  def subscribed
    invitee = User.find(params[:id])
    stream_for invitee
    # called once a user selects a challenger to add to the task
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
