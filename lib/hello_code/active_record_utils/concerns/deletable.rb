module HelloCode
  module ActiveRecordUtils
    module Concerns
      module Deletable
        extend ActiveSupport::Concern

        included do
          default_scope { where(deleted_at: nil) }

          scope :including_deleted, -> { unscope(where: :deleted_at) }
        end

        def delete!
          self.deleted_at = Time.now
          self
        end
      end
    end
  end
end
