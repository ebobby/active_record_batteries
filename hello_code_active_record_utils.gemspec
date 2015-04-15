$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
#require "hello_code_active_record_utils/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hello_code_active_record_utils"
  s.version     = "0.0.1" #HelloCodeActiveRecordUtils::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HelloCodeActiveRecordUtils."
  s.description = "TODO: Description of HelloCodeActiveRecordUtils."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
