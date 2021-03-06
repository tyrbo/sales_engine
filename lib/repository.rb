require 'csv'

class Repository
  class << self
    attr_reader :repo
  end

  def self.load(data, type)
    @repo = new(data, type)
  end

  def self.all
    repo.entries
  end

  def self.random
    repo.random
  end

  attr_reader :entries, :attributes

  def initialize(data, type)
    @entries = data.rows.map { |row| type.new(row) }
    @attributes = data.attributes
  end

  def inspect

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
