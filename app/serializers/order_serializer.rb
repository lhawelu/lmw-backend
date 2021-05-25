class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_amount, :tax_amount, :subtotal, :status, :items, :created_at
 
  def items
    ActiveModel::SerializableResource.new(object.order_items,  each_serializer: OrderItemSerializer)
  end

end