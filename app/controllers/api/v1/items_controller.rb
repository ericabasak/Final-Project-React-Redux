class Api::V1::ItemsController < ActionController::Base
  skip_before_action :verify_authenticity_token  


  # find items for a given user
  # item --> list --> user

  def index
    user = User.find_by(username: "Erica")
    list = List.find_by(user_id: user.id)
    puts "--------------------------------------------"
    puts list.id
    puts "-------------------------------------------"
    item = Item.find_by(list_id: list.id)
    puts "-----------------------------------------"
    puts item.name
    puts "----------------------------------------"
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
    p = item_params
    user = User.find_by(username: "Erica")
    list = List.find_by(user_id: user.id)
    item = Item.new(name: p[:name], is_complete: p[:is_complete], list_id: p[:list_id])
    item.save!
    render json: item
  end


  def update
    # look up item
    # upate field
    p = params.require(:item).permit(:is_complete, :id)
    item = Item.find(params[:id])
    item.update!(is_complete: p[:is_complete])
    item.save!
    render json: item
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :is_complete, :list_id)
  end

end
