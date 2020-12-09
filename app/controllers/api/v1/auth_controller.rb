class Api::V1::AuthController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: 200
    else
      render json: { error: "Invalid credentials" }, status: 401
    end
  end

  def get_current_user
    if logged_in_user
      puts @user
      render json: {user: @user}, status: 200
    else
      render json: {error: "not currently logged in"}, status: 401 
    end
  
  end

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