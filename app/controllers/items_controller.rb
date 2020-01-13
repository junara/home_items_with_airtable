class ItemsController < ApplicationController
  def index
    @items =  AirtableItem.all
  end

  def show
    @item = AirtableItem.find(params[:item_id])
    @maintenances = AirtableItem.maintenances(@item)
  end

  def maintain
    @item = AirtableItem.find(params[:item_id])
    date = params[:date] ? Date.parse(params[:date]) : Date.current
    note = params[:note].presence || nil
    AirtableItem.maintain(@item, date: date, note: note)
    redirect_to item_path(@item.id)
  end
end
