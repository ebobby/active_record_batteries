module HelloCode
  module ActiveRecordUtil
    module Loader
      extend ActiveSupport::Concern

      module ClassMethods
        def utility! (*modules)
          modules = modules.is_a?(Array) ? modules : [ modules ]

          modules.each.map{|i| i.to_s.camelize }.each do |mod|
            include HelloCode::ActiveRecordUtils::Concerns.const_get(mod)
          end

          nil
        end
      end

      ActiveRecord::Base.send(:include, self)
    end
  end
end
