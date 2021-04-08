class Api::V1::ItemsController < ApplicationController
  before_action :authorized

  def index
    user = User.find_by(username: params[:name])
    list = List.find_by(user_id: user.id)
    puts "----------------list.id----------------------------"
    puts list.id
    item = Item.find_by(list_id: list.id)
    puts "-----------------item.name------------------------"
    puts item.name
    items = Item.where(:list_id => list.id)
    puts items
    # items = Items.all
    render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  # 1. look for a user - find a specific user
  # 2. find list associated to user
  # 3. find list but if list doesnt exist then create the list
  # 4. create item
  # 5. associate item to list
  # 6. save it
  def create
    create_params = item_params
    item = Item.new(
      name: create_params[:name], 
      is_complete: false, #create_params[:is_complete], 
      list_id: create_params[:list_id])

    item.save!
    render json: item
  end

  def update
    # look up item
    # upate field
    # p = params.require(:item).permit(:is_complete, :id)
    p = item_params
    item = Item.find(params[:id])
    item.update!(is_complete: p[:is_complete])
    item.save!
    render json: item
  end
  
  def destroy
    puts "----------destroy---------------"
    # p = item_params
    item = Item.find(params[:id])
    # item.update!(name: p[:name])
    item.destroy!
    render json: item
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :is_complete, :list_id)
  end

end
