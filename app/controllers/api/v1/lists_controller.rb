class Api::V1::ListsController < ApplicationController
  before_filter: check_login
  
  def index
    lists = List.all
    render json: lists
  end

  def show
    list = List.find(params[:id])
    render json: list
  end

  def create
    list = List.create(list_params)
    @user = User.find(session[:user_id])
    list.user = @user
  end

  private
  
  def check_login
    if session[:user_id].nil?
      // redirect to login!
    end
  end

  def list_params
    params.require(:list).permit(:title, :description, :is_complete)
  end

end
