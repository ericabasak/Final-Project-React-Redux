class Api::V1::ListsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # before_action :require_login
  
  def index
    user = User.find_by(username: "Erica")
    # list = List.find_by(user_id: user.id)
    lists = List.where(:user_id => user.id)
    # puts "--------------------------"
    # puts lists
    # puts "---------------------------"
    # lists = List.all
    render json: lists
  end

  def show
    id = params[:id]
    list = List.find(id)
    items = Item.where(list_id: id)
    puts "*************items*********"
    puts list
    render json: items
  end

  def create
    x = list_params
    puts "------------------------------------------"
    puts x
    puts "----------------------------------------------"
    list = List.new(list_params)
    puts list
    puts "------------------------------------------"
    list = List.new(title: x[:title], description: x[:description], is_complete: x[:is_complete])
    user = User.find_by(username: "Erica")
    list.user = user
    list.save!
    puts list.title
    render json: list
  end

  def update
    puts "-----------updating list is complete-------------"
    p = list_params
    puts p
    list = List.find(params[:id])
    list.update!(is_complete: p[:is_complete])
    list.save!
    render json: list
  end

  private
  
  # def require_login
  #   if session[:user_id].nil?
  #     redirect to login
  #   end
  # end

  # def require_login
  #   unless login
  #     redirect_to login
  #   end
  # end


  # params is a request from client, params is object
  def list_params
    params.permit(:title, :description, :is_complete, :id)
  end

end
