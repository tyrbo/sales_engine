require 'csv'

class Repository
  attr_reader :entries

  def initialize
    @entries = []
  end

  def load(filename)
    CSV.open(filename, 'r', headers: true, header_converters: :symbol).each do |entry|
      entries << Customer.new(entry)
    end
  end
end
