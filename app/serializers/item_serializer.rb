class ItemSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description,:created_at, :updated_at, :price, :max_quantity, :scarcity, :people_per_unit, :bathroom, :user_id, :accommodation, :path

  has_many :availabilities

  def path
    item_path(object)
  end

  # def default_serializer_options
  #   {root: false}
  # end

end
