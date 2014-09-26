class ItemSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :created_at, :updated_at, :price, :max_quantity, :scarcity, :people_per_unit, :bathroom, :user_id, :accommodation, :path, :latitude, :longitude

  has_many :availabilities
  has_many :item_images
  has_one :address

  def path
    item_path(object)
  end

  # def default_serializer_options
  #   {root: false}
  # end

end
