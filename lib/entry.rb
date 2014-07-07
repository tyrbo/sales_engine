class Entry
  attr_reader :attributes

  def initialize(row)
    @attributes = row
  end

  private

  def method_missing(id, *args)
    if value = attributes[id]
        value
    else
      super
    end
  end
end
