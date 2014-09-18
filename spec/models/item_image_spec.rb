require 'rails_helper'

RSpec.describe ItemImage, :type => :model do
  describe 'with valid params' do
    it 'has an image and an item' do
      item = FactoryGirl.create :item
      item_image = ItemImage.create(
        image: File.open("spec/fixtures/missing.jpg", "r", item_id: item.id))

      expect(item_image).to respond_to :image
      expect(item_image).to respond_to :item
    end
  end
end
