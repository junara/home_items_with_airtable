class AirtableItem
  API_KEY = ENV['AIRTABLE_API_KEY']
  APP_TOKEN = ENV['AIRTABLE_APP_TOKEN']
  WORKSHEET_NAME = 'items'

  attr_reader :client, :table, :api_key, :app_token
  delegate :find, :select, :all, to: :table

  def initialize(api_key: nil, app_token: nil, work_sheet_name: nil)
    @api_key = api_key || API_KEY
    @app_token = app_token || APP_TOKEN
    @work_sheet_name = work_sheet_name || WORKSHEET_NAME
  end

  def self.table
    self.new.table
  end

  def self.find(record_id)
    self.new.find(record_id).presence || raise
  end

  def self.select(sort: [], formula: '')
    self.new.select(sort: sort, formula: formula) || []
  end

  def self.all(sort: [])
    self.new.all(sort: sort) || []
  end

  def table
    @table ||= client.table(@app_token, @work_sheet_name)
  end

  private

  def client
    @client ||= Airtable::Client.new(@api_key)
  end

end