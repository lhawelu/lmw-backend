class Api::V1::OrderItemsController < ApplicationController

  def destroy
    current_order = Order.find_by(id: order_items_params[:order_id], user: @@user)
    item = OrderItem.find_by(id: order_items_params[:order_item_id])
    item.destroy
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

  def order_items_params
    params.require(:order_item).permit(:order_item_id, :order_id)
  end
  
end
