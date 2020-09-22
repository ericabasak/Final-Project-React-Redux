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

  def create
    puts session[:user_id]
    item = Item.create(item_params)
    list = List.find_by(user_id: session[:user_id])
    item.list_id = list.id;
    item.save!
    render json: item
  end

  private

  def item_params
    params.require(:item).permit(:name, :is_complete)
  end

end
