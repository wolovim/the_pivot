class ItemSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description,:created_at, :updated_at, :price, :max_quantity, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :scarcity, :people_per_unit, :bathroom, :user_id, :accommodation, :path

  def path
    item_path(object)
  end

  # def default_serializer_options
  #   {root: false}
  # end

end
