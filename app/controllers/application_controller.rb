class ApplicationController < ActionController::API

  # skip_before_action :verify_authenticity_token

  # helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!
  # helper_method :logged_in?, :current_user


  # def login!
  #   session[:user_id] = @user.id
  # end

  def current_user
    # @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # !!session[:user_id]
    !!current_user
  end
  
  

  # def authorized_user?
  #    @user == current_user
  # end

  # def logout!
  #  session.clear
  # end

end
