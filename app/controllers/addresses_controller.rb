class AddressesController < ApplicationController

  def new
    @item = current_user.items.find(params[:item_id])
    @address = Address.new
  end

  def create
    @item = current_user.items.find(params[:item_id])
    @address = @item.build_address(address_params)

    if @address.save
      redirect_to new_item_image_path(@item)
    else
      flash[:errors] = @address.errors.messages
      render :new
    end
  end

  def edit
    @item = current_user.items.find(params[:item_id])
    @address = @item.address
  end

  def update
    @item = current_user.items.find(params[:item_id])
    @address = @item.address

    if @address.update(address_params)
      redirect_to new_item_image_path(@item)
    else
      flash[:errors] = @address.errors.messages
      render "orders/checkout"
    end
  end

  def address_params
    params.require(:address).permit(:street_1, :street_2, :city, 
                                    :state, :zip, :item_id)
  end
end
