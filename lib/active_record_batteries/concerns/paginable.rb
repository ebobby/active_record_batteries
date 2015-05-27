module ActiveRecordBatteries
  module Concerns
    module Paginable
      extend ActiveSupport::Concern

      included do
        # Default items per page
        page_items 25

        scope :paginate, lambda { |page, page_items = @page_items|
          limit(page_items)
            .offset(([page.to_i, 1].max - 1) * page_items)
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
        def page_items(items)
          @page_items = items
        end

        def pages(page_items = @page_items)
          (all.except(:offset, :limit, :order, :includes)
            .distinct(:id).count / page_items.to_f).ceil
        end
      end
    end
  end
end
