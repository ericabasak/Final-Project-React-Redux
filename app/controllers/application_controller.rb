class ApplicationController < ActionController::Base
  # before_action :require_login
  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def login!
    session[:user_id] = @user.id
  end

  def logged_in?
    !!session[:user_id]
    # !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
    # @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorized_user?
     @user == current_user
  end

  def logout!
   session.clear
  end

# private

#   def require_login
#     unless logged_in?
#       redirect_to create
#     end
#   end

end
