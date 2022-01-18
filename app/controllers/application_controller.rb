class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user

  def current_user
      User.find_by(id: session[:user_id])  
  end

  def logged_in?
      !current_user.nil?
  end

  # before_action :authorized
  def authorized
    redirect_to '/login', status: :unauthorized unless logged_in?
    # render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
