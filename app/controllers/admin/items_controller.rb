class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end
end
