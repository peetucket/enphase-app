class ApplicationController < ActionController::Base
  before_action :check_authorization

  def check_authorization
    return if Settings.token.blank? # ok if we have no token
    head :forbidden unless params[:token] == Settings.token # forbidden unless token matches
  end
end
