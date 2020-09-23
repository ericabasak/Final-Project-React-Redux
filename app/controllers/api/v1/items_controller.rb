class Api::V1::ItemsController < ActionController::Base
  skip_before_action :verify_authenticity_token  

  def index
    items = Items.all
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

    user = User.find_by(username: "zoey")
    list = List.find_by(user_id: user.id)
    item = Item.create(name: x[:name], is_complete: x[:is_complete])
    if list.nil?
      l = List.create(title: "", description: "", is_complete: false, user_id: user.id)
      l.save!
    elsif
    # variable = value
      item.list_id = list.id 
    end
    render json: user
  end

  private

  def item_params
    params.require(:item).permit(:name, :is_complete)
  end

end
