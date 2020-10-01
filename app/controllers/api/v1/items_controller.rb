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
    x = item_params()
    puts "Erica =-----------------------------------------------------"
    puts x
    puts "Erica =-----------------------------------------------------"

    user = User.find_by(username: "Erica")
    list = List.find_by(user_id: user.id)
    puts 'list id -', list.id
    item = Item.new(name: x[:name], is_complete: x[:is_complete])
    puts item.id
    if list.nil?
      list = List.create!(title: "", description: "", is_complete: false, user_id: user.id)
    end
    item.list_id = list.id 
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
    params.require(:item).permit(:name, :is_complete, :id)
  end

end
