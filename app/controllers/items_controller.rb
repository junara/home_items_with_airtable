class ItemsController < ApplicationController
  def index
    @items =  AirtableItem.all
  end

  def show
    @item = AirtableItem.find(params[:record_id])
  end
end
