module ActiveRecordBatteries
  module Concerns
    extend ActiveSupport::Autoload

    autoload :Deletable,          'active_record_batteries/concerns/deletable'
    autoload :Filterable,         'active_record_batteries/concerns/filterable'
    autoload :Paginable,          'active_record_batteries/concerns/paginable'
    autoload :Sluggable,          'active_record_batteries/concerns/sluggable'
    autoload :RelationshipScopes, 'active_record_batteries/concerns/relationship_scopes'
  end
end
