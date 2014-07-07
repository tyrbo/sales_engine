require 'csv'

class Repository
  class << self
    attr_reader :repo
  end

  def self.load(filename, type)
    @repo = new(filename, type)
  end

  def self.all
    repo.entries
  end

  def self.random
    repo.random
  end

  attr_reader :entries, :attributes

  def initialize(filename, type)
    @entries = []
    CSV.open(filename, 'r', headers: true, header_converters: :symbol) do |csv|
      csv.each do |entry|
        entries << type.new(entry)
      end
      @attributes = csv.headers
    end
  end

  def random
    entries.sample
  end

  def find(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    entries.detect { |entry| entry.send(attribute).to_s == value }
  end

  def find_all(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    entries.select { |entry| entry.send(attribute).to_s == value }
  end

  def attribute_exists?(attribute)
    attribute && attributes.include?(attribute[1].to_sym)
  end

  private

  def self.method_missing(id, *args)
    name = id.to_s
    find_attribute = name.match(/\Afind_by_(.+)\z/)
    all_attribute = name.match(/\Afind_all_by_(.+)\z/)
    if repo.attribute_exists?(find_attribute)
      repo.find(find_attribute[1], args.first)
    elsif repo.attribute_exists?(all_attribute)
      repo.find_all(all_attribute[1], args.first)
    else
      super
    end
  end
end
