class Api::V1::OrdersController < ApplicationController

  def index
    orders = @@user.orders.select{|order| order.status === 'completed'}.map{|order| OrderSerializer.new(order)}
    render json: { orders: orders }, status: :ok
  end

  def complete_order
    order = Order.find_by(id: completed_order_params[:id], user: @@user)
    order.status = 'completed'
    if order.save
      render json: { message: 'Order Submitted'}, status: :ok
    else
      render json: { error: 'Failed to complete order. Please try again.' }, status: :not_acceptable
    end
  end
  
  def current_order
    pending_order = @@user.orders.find_by(status: 'pending')
    if pending_order
      render json: { current_order: OrderSerializer.new(pending_order) }, status: :ok
    else
      new_order = Order.create(user: @@user, status: 'pending')
      render json: { current_order: OrderSerializer.new(new_order) }, status: :ok
    end
  end

  def add_item
    current_order = Order.find_by(id: order_items_params[:order_id], user: @@user)
    new_item = OrderItem.create(order_items_params)
    new_subtotal = current_order.items.sum(:price).round(2)
    current_order.subtotal = new_subtotal
    current_order.tax_amount = (new_subtotal * 0.0875).round(2)
    current_order.total_amount = (new_subtotal * 1.0875).round(2)
    if current_order.save
      render json: { current_order: OrderSerializer.new(current_order) }, status: :ok
    else
      render json: { error: 'Failed to add item. Please try again.' }, status: :not_acceptable
    end
  end

  private

  def completed_order_params
    params.require(:order).permit(:id)
  end

  def order_items_params
    params.require(:order_item).permit(:order_id, :item_id, :special_instructions)
  end

end
