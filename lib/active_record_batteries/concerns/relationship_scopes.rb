module ActiveRecordBatteries
  module Concerns
    module RelationshipScopes
      extend ActiveSupport::Concern

      module ClassMethods
        def relationship_scopes(relationship, suffix = nil)
          suffix ||= relationship

          scope "with_#{ suffix }".to_sym,    -> { joins(relationship) }
          scope "include_#{ suffix }".to_sym, -> { includes(relationship) }
          scope "and_#{ suffix }".to_sym,     -> { send(with_scope_name).send(include_scope_name) }
          scope "pload_#{ suffix }".to_sym,   -> { preload(relationship) }
          scope "eload_#{ suffix }".to_sym,   -> { eager_load(relationship) }

          nil
        end
      end
    end
  end
end
