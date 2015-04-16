$:.push File.expand_path("../lib", __FILE__)

require "hello_code/active_record_utils/version"

Gem::Specification.new do |s|
  s.name        = "hello_code_active_record_utils"
  s.version     = HelloCode::ActiveRecordUtils::VERSION
  s.authors     = ["Francisco Soto"]
  s.email       = ["bobby@hellocode.mx"]
  s.homepage    = "https://github.com/HelloCodeMX/active_record_utils"
  s.summary     = "ActiveRecord extensions to make life easier."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency             "rails", "~> 4.2.1"
  s.add_development_dependency "sqlite3"
end
