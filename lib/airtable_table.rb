module Airtable
  class Table
    # Override AT's create method to pass "typecast" param
    def create(record)
      result = self.class.post(worksheet_url,
        :body => { "fields" => record.fields, "typecast" => true }.to_json,
        :headers => { "Content-type" => "application/json" }).parsed_response

      check_and_raise_error(result)

      record.override_attributes!(result_attributes(result))
      record
    end

    protected
      def check_and_raise_error(response)
        response['error'] ? raise(Error.new(response['error'])) : false
      end
  end
end
