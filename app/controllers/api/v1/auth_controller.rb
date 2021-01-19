class Api::V1::AuthController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      puts 'founder user ', @user
      puts token
      puts @user.id
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
  