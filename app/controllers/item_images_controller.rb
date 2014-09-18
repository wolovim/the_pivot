class ItemImagesController < ApplicationController
  def new
    @item = current_user.items.find(params[:item_id])
    @item_image = ItemImage.new
  end

  def create
    @item = current_user.items.find(params[:item_id])
    @item_image = @item.item_images.new(item_image_params)

    if @item_image.save
      redirect_to new_item_image_path(@item.id)
    else
      render :new
    end
  end

  def item_image_params
    params.require(:item_image).permit(:image)
  end
end
