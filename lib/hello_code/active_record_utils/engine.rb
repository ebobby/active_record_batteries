module HelloCode
  module ActiveRecordUtils
    class Engine < ::Rails::Engine
      isolate_namespace HelloCode
    end
  end
end
