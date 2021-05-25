class Api::V1::OrdersController < ApplicationController

  def index
    orders = @@user.orders.all.map{|order| OrderSerializer.new(order)}
    render json: { orders: orders }, status: :ok
  end
  
end