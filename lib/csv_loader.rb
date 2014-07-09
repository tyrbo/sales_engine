require 'csv'

class CSVLoader
  attr_reader :rows, :attributes

  def initialize(filename)
    CSV.open(filename, 'r', headers: true, header_converters: :symbol) do |csv|
      @rows = csv.map do |entry|
        entry
      end
      @attributes = csv.headers
    end
  end
end
