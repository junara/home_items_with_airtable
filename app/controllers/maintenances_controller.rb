class MaintenancesController < ApplicationController
  def destroy
    @item = AirtableItem.find(params[:item_id])
    maintenance = AirtableMaintenance.find(params[:maintenance_id])
    AirtableMaintenance.destroy(maintenance.id)
    if request.xhr?
      render json: { success: true }
    else
      redirect_to 'https://yahoo.co.jp'
    end
  end
end
