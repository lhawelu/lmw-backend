class Api::V1::OrdersController < ApplicationController

  def index
    orders = @@user.orders.all.map{|order| OrderSerializer.new(order)}
    render json: { orders: orders }, status: :ok
  end

  def create
    order = Order.new(order_params)
    params[:items].each{ |item| order.items << Item.find(item) }
    order.user = @@user
    if order.save
      render json: { message: 'order created'}, status: :created
    else
      render json: { error: 'failed to create order' }, status: :not_acceptable
    end
  end
  
  def order_params
    params.require(:order).permit(:total_amount, :tax_amount, :subtotal)
  end
end