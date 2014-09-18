class ItemImagesController < ApplicationController
  def new
    @item_image = ItemImage.new
  end

  def create
    @item_image = ItemImage.new(image_item_params)

    if @item_image.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def image_item_params
    params.require(:item_image).permit(:image)
  end
end
