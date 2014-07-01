require 'csv'

class Repository
  def self.load(filename, type)
    @entries = []
    CSV.open(filename, 'r', headers: true, header_converters: :symbol) do |csv|
      csv.each do |entry|
        @entries << type.new(entry)
      end
      @attributes = csv.headers
    end
  end

  def self.all
    @entries
  end

  def self.random
    @entries.sample
  end

  def self.method_missing(id, *args)
    name = id.to_s
    find_attribute = name.match(/\Afind_by_(.+)\z/)
    all_attribute = name.match(/\Afind_all_by_(.+)\z/)
    if attribute_exists?(find_attribute)
      find(find_attribute[1], args.first)
    elsif attribute_exists?(all_attribute)
      find_all(all_attribute[1], args.first)
    else
      super
    end
  end

  def self.find(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    @entries.detect { |entry| entry.send(attribute) == value }
  end

  def self.find_all(attribute, value)
    attribute = attribute.to_sym
    value = value.to_s
    @entries.select { |entry| entry.send(attribute) == value }
  end

  private

  def self.attribute_exists?(attribute)
    attribute && @attributes.include?(attribute[1].to_sym)
  end
end
