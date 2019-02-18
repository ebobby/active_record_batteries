module ActiveRecordBatteries
  module Concerns
    extend ActiveSupport::Autoload

    autoload :Deleteable,         'active_record_batteries/concerns/deleteable'
    autoload :Filterable,         'active_record_batteries/concerns/filterable'
    autoload :Paginable,          'active_record_batteries/concerns/paginable'
    autoload :Sluggable,          'active_record_batteries/concerns/sluggable'
    autoload :RelationshipScopes, 'active_record_batteries/concerns/relationship_scopes'
  end
end
