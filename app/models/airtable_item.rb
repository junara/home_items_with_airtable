class AirtableItem
  include AirtableRecordable
  default api_key: ENV['AIRTABLE_API_KEY'],
          app_token: ENV['AIRTABLE_APP_TOKEN'],
          work_sheet_name: 'items'

  def self.maintain(item, date: Date.current, note: nil)
    maintenance = maintenances(item)&.first || Airtable::Record.new

    maintenance[:date] = date.to_s
    maintenance[:note] = note if note

    maintenance.id.present? ? update_maintenance(maintenance) : add_maintenance(item, maintenance)
  end

  def self.add_maintenance(item, maintenance)
    maintenance[:items] = [item.id]
    AirtableMaintenance.create(maintenance)
  end

  def self.update_maintenance(maintenance)
    AirtableMaintenance.update(maintenance)
  end

  def self.maintenances(item)
    AirtableMaintenance.select(formula: "ARRAYJOIN(items) = '#{item.name}'").presence || []
  end
end