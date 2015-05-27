module ActiveRecordBatteries
  module Loader
    extend ActiveSupport::Concern

    module ClassMethods
      def batteries! (*modules)
        modules = modules.is_a?(Array) ? modules : [ modules ]

        modules.each.map{|i| i.to_s.camelize }.each do |mod|
          include ActiveRecordBatteries::Concerns.const_get(mod)
        end

        nil
      end
    end

    ActiveRecord::Base.send(:include, self)
  end
end
