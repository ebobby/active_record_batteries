module ActiveRecordBatteries
  module Concerns
    module RelationshipScopes
      extend ActiveSupport::Concern

      module ClassMethods
        def relationship_scopes(relationship, suffix = nil)
          suffix ||= relationship

          with_scope_name    = "with_#{ suffix }".to_sym
          include_scope_name = "include_#{ suffix }".to_sym

          scope with_scope_name,              -> { joins(relationship) }
          scope include_scope_name,           -> { includes(relationship) }
          scope "and_#{ suffix }".to_sym,     -> { send(with_scope_name).send(include_scope_name) }
          scope "pload_#{ suffix }".to_sym,   -> { preload(relationship) }
          scope "eload_#{ suffix }".to_sym,   -> { eager_load(relationship) }

          nil
        end
      end
    end
  end
end
