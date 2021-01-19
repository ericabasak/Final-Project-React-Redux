require 'bcrypt'

class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def show
    users = User.find(params[:id])
    puts "-------user--------"
    render json: users
  end

  def create
    user = User.create(user_params)
    # user.password_digest =  BCrypt::Password.create(user.password_digest)
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

  private

  def user_params
    params.permit(:username, :email, :password)
  end

end