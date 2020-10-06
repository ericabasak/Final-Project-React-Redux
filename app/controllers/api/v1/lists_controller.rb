class Api::V1::ListsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # before_action :check_login
  
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
    list = List.find(params[:id])
    render json: list
  end

  def create
    x = list_params
    puts "------------------------------------------"
    puts x
    puts "----------------------------------------------"
    list = List.new(list_params)
    puts list
    puts "------------------------------------------"
    list = List.new(title: x[:title], description: x[:description], 
    is_complete: x[:is_complete])
    user = User.find_by(username: "Erica")
    list.user = user
    list.save!
    puts list.title
    render json: list
  end

  private
  
  # def check_login
  #   if session[:user_id].nil?
  #     redirect to login!
  #   end
  # end

  def list_params
    params.require(:list).permit(:title, :description, :is_complete)
  end

end
