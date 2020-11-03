class Api::V1::SessionsController < ApplicationController
  

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params [:user][:email])
      session[:user_id] = @user.id;
      resp = {
        user: @user.user_serializer
      }
      render json: resp
    else
      resp = {
        error: "Invalid credentials",
        details: @user.errors.full_messages
      }
      render json: resp, status: :authorized
    end
  end

  def get_current_user
    if logged_in?
      render json: {
        user: current_user.user.serializer
      }, status: :ok
    else
      render json: { error: "No current user"}
    end
  end

  def destroy
    if session.clear
      render json: {
        message: "Successfully logged out"
      }, status: :ok
    else
      render json: {
        error: "Something went wrong"
      }, status: 500
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
end