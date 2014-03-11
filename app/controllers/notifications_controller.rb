class NotificationsController < ApplicationController
  before_action :signed_in_user, only: [:index]
  
  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end
  
  def mark
    @notifications = current_user.notifications
    @notifications.unread.update_all(read: true)

    respond_to do |format|
      format.js
    end
  end
end
