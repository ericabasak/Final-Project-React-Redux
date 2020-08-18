class Api::V1::ItemsController < ApplicationController
  def index
    items = Items.all
    render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
  end

end
