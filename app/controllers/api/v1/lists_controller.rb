class Api::V1::ListsController < ApplicationController
  before_action :authorized
  # when user does login then the authorized method runs in the application controller
  
  def index
    puts "***************************"
    puts @user
    # hash(:user_id => @user.id)
    # key = :user_id
    # value = @user.id
    lists = List.where(:user_id => @user.id)
    puts "--------------------------"
    puts lists
    puts "---------------------------"
    # all method returns all given lists for a user in the database
    lists = List.all
    render json: lists
  end

  def show
    # id = params[:id] 
    # WHAT IS THE DIFFERENCE BETWEEN LIST_PARAMS & PARAMS?????????????
    # IS PARAMS[:ID] ASSUMED FOR ALL STRONG PARAMS
    puts "--------params id----------"
    puts params[:id]
    # params[:id] is the id of the list
    list = List.find(params[:id])
    puts "-------list----------"
    puts list
    # search all items where the list_id is equal to the list.id
    items = Item.where(list_id: params[:id])
    puts "-------items---------"
    puts items
    render json: items
  end

  def create
    x = list_params
    # why wouldn't you want List.create and then you can skip the save! down below?
    # isnt' line 41 & 41 basically the same? both contain list_params more or less
    list = List.new(list_params)
    list = List.new(title: x[:title], description: x[:description], is_complete: x[:is_complete])
    # where is this user coming from? and the @user coming from ApplicationController
    list.user = @user
    list.save!
    render json: list
  end

  def update
    # this method is editing/updating list
    p = list_params
    puts "----------p-------"
    puts p
    puts "----------p-------"
    # finds the list with that id
    list = List.find(params[:id])
    puts "----------list-------"
    puts list
    puts "----------list-------"
    # updating list attribute is_complete with checkbox
    list.update!(is_complete: p[:is_complete])
    list.save!
    puts "----------list-------"
    puts list
    puts "----------list-------"
    render json: list
  end

  private

  # params is a request from client, params is object
  def list_params
    params.require(:list).permit(:title, :description, :is_complete, :id)
  end

end
