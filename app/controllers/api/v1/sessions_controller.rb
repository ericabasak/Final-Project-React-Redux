class Api::V1::SessionsController < ApplicationController
  
  def create
    puts "----------params-------------"
    puts params
    puts "------------params------------"
    session[:test] = "Session test"
    @user = User.find_by(username: params[:username])
  
    # todo add user.authenticate(params[:password]) bcrypt
    # if !@user.nil? && @user.authenticate(password)
    if !@user.nil?
      session[:user_id] = @user.id;
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: 200
    else
      render json: { errors: "Invalid credentials" }, status: 401
    end
  end

  def get_current_user
    if logged_in?
      render json: { user: current_user.user.serializer }, status: 200
    else
      render json: { error: "No current user" }, status: 401
    end
  end

  # deletes or clears the session
  def destroy
    session.clear
    render json: { message: "Successfully logged out" }, status: 200
  end

end
  


  # def create
  #     user = User.find_by(email: session_params[:email])
    
  #     if user && user.authenticate(session_params[:password])
  #       login!
  #       render json: {
  #         logged_in: true,
  #         user: user
  #       }
  #     else
  #       render json: { 
  #         status: 401,
  #         errors: ['Invalid credentials']
  #       }
  #     end
  #   end
  # def is_logged_in?
  #     if logged_in? && current_user
  #       render json: {
  #         logged_in: true,
  #         user: current_user
  #       }
  #     else
  #       render json: {
  #         logged_in: false,
  #         message: 'no such user'
  #       }
  #     end
  #   end
  # def destroy
  #     logout!
  #     render json: {logged_out: true}
  # end

  # private
  
  # def session_params
  #     params.require(:user).permit(:username, :email, :password)
  # end