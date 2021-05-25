class OrderItemSerializer < ActiveModel::Serializer
  attributes :special_instructions
  belongs_to :item
  
end