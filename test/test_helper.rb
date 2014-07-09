require 'minitest/autorun'
require 'minitest/pride'

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file[0...-3] }
