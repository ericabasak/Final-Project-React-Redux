require 'bcrypt'

class Api::V1::UsersController < ApplicationController
  
  def index
    users = User.all
    render json: users
  end

  def show
    users = User.find(params[:id])
    render json: users
  end

  def create
    user = User.create(user_params)
    user.password_digest =  BCrypt::Password.create(user.password_digest)
    puts user
    user.hello()

    if user.save
      render json: user, status: 200
    else
      render json: {errors: user.errors.full_messages}, status: 500
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: user
    else
      render json: {errors: "Login failed!"}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password_digest)
  end

  # def login_params
  #   params.require(:user).permit(:username, :password)
  # end
end