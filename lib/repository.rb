require 'csv'
require 'pry'

class Repository
  attr_reader :entries, :type, :attributes

  def initialize(type)
    @entries = []
    @attributes = []
    @type = type
  end

  def load(filename)
    CSV.open(filename, 'r', headers: true, header_converters: :symbol) do |csv|
      csv.each do |entry|
        entries << type.new(entry)
      end
      @attributes = csv.headers
    end
  end

  def all
    @entries
  end

  def random
    @entries.sample
  end

  def method_missing(id, *args)
    name = id.to_s
    attribute = name.match(/\Afind_by_(.+)\z/)
    if attribute && attributes.include?(attribute[1].to_sym)
      find(attribute[1], args.first)
    else
      super
    end
  end

  def find(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    entries.detect { |entry| entry.send(attribute) == value }
  end

  def find_all(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    entries.select { |entry| entry.send(attribute) == value }
  end
end
