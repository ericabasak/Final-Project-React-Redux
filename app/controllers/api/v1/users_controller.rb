require 'bcrypt'

class Api::V1::UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token

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
    # user.password_digest =  BCrypt::Password.create(user.password_digest)
    puts user
    # user.hello()

    if user.save
      render json: user, status: 200
    else
      render json: {
        status: 500,
        errors: user.errors.full_messages
      } 
    end
  end

  # def login
  #   puts "i want to login"
  #   user = User.find_by(params[:id])
  #   if user
  #     session[:user_id] = user.id
  #     puts "session - #{session[:user_id]}";
  #     render json: user
  #   else
  #     render json: {
  #       errors: "Login failed!"
  #     }
  #   end
  # end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

end