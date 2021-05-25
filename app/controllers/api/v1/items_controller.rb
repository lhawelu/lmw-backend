class Api::V1::ItemsController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @items = Item.all
    byebug
    render json: @items
  end

end