module AirtableRecordable
  extend ActiveSupport::Concern

  included do
    delegate :find, :select, :all, :create, :update,:destroy, to: :table

    def table
      @table ||= client.table(app_token, work_sheet_name)
    end

    def client
      @client ||= Airtable::Client.new(api_key)
    end
  end

  class_methods do
    def default(attr)
      attr.each do |k, v|
        define_method(k) do
          v
        end
      end
    end

    def all(sort: [])
      self.new.all(sort: sort) || []
    end

    def table
      self.new.table
    end

    def find(record_id)
      self.new.find(record_id).presence || raise
    end

    def select(options)
      self.new.select(options) || []
    end

    def create(record)
      self.new.create(record)
    end

    def update(record)
      self.new.update(record)
    end

    def destroy(record_id)
      self.new.destroy(record_id)
    end
  end
end
