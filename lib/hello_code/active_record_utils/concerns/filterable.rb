module HelloCode
  module ActiveRecordUtils
    module Concerns
      module Filterable
        extend ActiveSupport::Concern

        included do
          scope :filtered, lambda { |values|
            current = all
            filters.each do |key, method|
              if values.try(:key?, key)
                current = current.send(method, values[key]) if
                  current.respond_to?(method)
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
