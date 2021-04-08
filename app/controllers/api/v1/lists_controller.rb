class Api::V1::ListsController < ApplicationController
  before_action :authorized
  # when user does login then the authorized method runs in the application controller
  
  def index
    puts @user
    # hash(:user_id => @user.id)
    # key = :user_id
    # value = @user.id
    # find lists that match the user and sort through all lists in alphabetical order case insensitive
    lists = List.where(:user_id => @user.id).sort_by {|l| l.title.downcase  }
    puts "--------------------------"
    puts lists.map{|e| e.title}
    puts "---------------------------"
    # all method returns all given lists for a user in the database
    render json: lists
  end

  def show
    # id = params[:id] 
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
    # finds the list with that id
    list = List.find(params[:id])
    # updating list attribute is_complete with checkbox
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
