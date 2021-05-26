class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :category
  
  def category
    ActiveModel::SerializableResource.new(object.category,  each_serializer: CategorySerializer)
  end

end