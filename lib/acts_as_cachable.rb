class Object
  def metaclass
    class << self
      self
    end
  end
end

module ActiveRecord
  module MySuperB
    def self.included(base)
      base.module_eval do 
        def self.acts_as_cachable(options={})
          default_configuration = {
          :methods=>[:all,:first,:last]
            }.merge(options)
            default_configuration[:methods].each do |m|
              next unless self.respond_to?(m.to_sym)
              self.metaclass.send(:alias_method, "uncached_#{m}".to_sym, "#{m}".to_sym)
              self.metaclass.send(:define_method,"#{m}".to_sym) do
                 Rails.cache.fetch("#{self.class.name}_#{m}") do
                  "uncached_#{m}"
                end
              end
            end
        end
      end
    end
  
  end
end
class ActiveRecord::Base
  include ActiveRecord::MySuperB
end