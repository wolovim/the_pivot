class Cart < ActiveRecord::Base
  has_many :items
  belongs_to :user

  # def add_item(params)
  #   self.items.create(params)
  # end
end
