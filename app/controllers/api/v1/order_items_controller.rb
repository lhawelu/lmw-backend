class Api::V1::OrderItemsController < ApplicationController

  def destroy
    current_order = Order.find_by(id: order_items_params[:order_id])
    item = OrderItem.find_by(id: order_items_params[:order_item_id])
    if item.destroy
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
