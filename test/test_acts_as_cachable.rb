require 'helper'

class TestActsAsCachable < Test::Unit::TestCase
  def setup
    MyClass.send(:acts_as_cachable)
    @m = MyClass.new
  end
  
  should "m be valid" do
    assert @m
  end
  
  should "@m acts_as_cachable" do
    assert MyClass.respond_to?(:uncached_all)
  end
end