module HelloCode
  module ActiveRecordUtils
    module Concerns
      extend ActiveSupport::Autoload

      autoload :Deletable,          'hello_code/active_record_utils/concerns/deletable'
      autoload :Filterable,         'hello_code/active_record_utils/concerns/filterable'
      autoload :Paginable,          'hello_code/active_record_utils/concerns/paginable'
      autoload :Sluggable,          'hello_code/active_record_utils/concerns/sluggable'
      autoload :RelationshipScopes, 'hello_code/active_record_utils/concerns/relationship_scopes'
    end
  end
end
