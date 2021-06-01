class OrderItemSerializer < ActiveModel::Serializer
  attributes :special_instructions, :order_item_id
  belongs_to :item
  
  def order_item_id
    object.id
  end
end