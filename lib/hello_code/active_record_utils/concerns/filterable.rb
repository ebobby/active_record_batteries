module HelloCode
  module ActiveRecordUtils
    module Concerns
      module Filterable
        extend ActiveSupport::Concern

        included do
          scope :filtered, ->(values) {
            current = all
            filters.each do |key, method|
              if values.try(:key?, key) && current.respond_to?(method)
                current = current.send(method, values[key])
              end
            end
            current
          }
        end

        module ClassMethods
          def add_filter(filter_key, method_name, callable = nil)
            scope(method_name, callable) if callable
            filters[filter_key] = method_name
          end

          def filters
            @filters ||= {}
          end
        end
      end
    end
  end
end
