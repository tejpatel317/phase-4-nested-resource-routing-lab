class ItemsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
    else 
      item = Item.find(params[:id])
    end
    render json: item, include: :user
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(name: params[:name], description: params[:description], price: params[:price])
    else 
      item = Item.create(name: params[:name], description: params[:description], price: params[:price])
    end
    render json: item, include: :user, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

end
