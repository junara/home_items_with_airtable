class AirtableMaintenance
  include AirtableRecordable
  default api_key: ENV['AIRTABLE_API_KEY'],
          app_token: ENV['AIRTABLE_APP_TOKEN'],
          work_sheet_name: 'maintenances'
end