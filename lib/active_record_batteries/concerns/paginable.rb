module ActiveRecordBatteries
  module Concerns
    module Paginable
      extend ActiveSupport::Concern

      included do
        # Default items per page
        items_per_page 25

        scope :paginate, lambda { |page, items_per_page = @items_per_page|
          limit(items_per_page)
            .offset(([page.to_i, 1].max - 1) * items_per_page)
            .extending do

            def current_page
              @current_page ||=
                if total_pages.zero?
                  0
                else
                  (offset_value / limit_value.to_f).ceil + 1
                end
            end

            # If pagination is used this
            def total_items
              @total_items ||=
                begin
                  total_rows = except(:offset, :limit, :order)
                  total_rows = total_rows.except(:includes) if eager_loading?
                  total_rows.distinct(:id).count
                end
            end

            def total_pages
              @total_pages ||=
                begin
                  (total_items / limit_value.to_f).ceil
                end
            end
          end
        }
      end

      module ClassMethods
        def items_per_page(items)
          @items_per_page = items
        end

        def pages
          (all.except(:offset, :limit, :order, :includes)
            .distinct(:id).count / @items_per_page.to_f).ceil
        end
      end
    end
  end
end
