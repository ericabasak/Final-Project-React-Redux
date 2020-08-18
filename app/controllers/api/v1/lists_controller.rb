class Api::V1::ListsController < ApplicationController

  def index
    lists = List.all
    render json: lists
  end

  def show
    list = List.find(params[:id])
    render json: list
  end

  def create
    list = List.create(list_params)
  end

  private
  
  def list_params
    params.require(:list).permit(:title, :description, :is_complete)
  end

end
