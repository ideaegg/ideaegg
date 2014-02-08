class UploadsController < ApplicationController
  before_action :signed_in_user

  def uptoken
    token = Qiniu::RS.generate_upload_token({ scope: 'ideaegg' })
    render json: { uptoken: token }
  end
end
