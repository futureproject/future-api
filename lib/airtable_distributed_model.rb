module Airtable

  class Model < Record
  end

  class DistributedModel < Model

    def self.table(city)
      data_locator = DB[self.name.tableize.to_sym][city] || raise(NoSuchBase)
      @@client.table(data_locator, self.name.pluralize)
    end

    def save
      if new_record?
        self.class.table(self.goddamn_city_id).create(self)
      else
        self.class.table.update_record_fields(id, self.changed_fields)
      end
    end

    def changed_fields
      current = fields
      old = self.class.find(id).fields
      current.diff(old)
    end

    def destroy
      self.class.table.destroy(id)
    end

    def update(fields)
      self.class.table.update_record_fields(id, fields)
    end

  end
end
