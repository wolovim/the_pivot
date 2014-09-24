class ItemImageSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :image_file_name, :json_image_link

end
