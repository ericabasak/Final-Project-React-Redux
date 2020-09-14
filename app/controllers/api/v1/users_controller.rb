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
    login!
    if user.save
      render json: user, status: 200
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password_digest)
  end
end