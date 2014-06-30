require_relative 'test_helper'
require_relative '../lib/sales_engine'

class IntegrationTest < MiniTest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new
    sales_engine.startup
  end
end
