class Api::V1::ListsController < ApplicationController
  before_action :authorized
  
  def index
    puts 'session-----'
    puts session[:user_id]
    puts session[:test]
    puts "***************************"
    puts @user
    # hash(:user_id => @user.id)
    lists = List.where(:user_id => @user.id)
    puts "--------------------------"
    puts lists
    puts "---------------------------"
    lists = List.all
    render json: lists
  end

  def show
    id = params[:id]
    list = List.find(id)
    items = Item.where(list_id: id)
    render json: items
  end

  def create
    x = list_params
    list = List.new(list_params)
    list = List.new(title: x[:title], description: x[:description], is_complete: x[:is_complete])
    list.user = @user
    list.save!
    render json: list
  end

  def update
    p = list_params
    list = List.find(params[:id])
    list.update!(is_complete: p[:is_complete])
    list.save!
    render json: list
  end

  private



  # params is a request from client, params is object
  def list_params
    params.require(:list).permit(:title, :description, :is_complete, :id)
  end

end
