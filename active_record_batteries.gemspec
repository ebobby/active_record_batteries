$:.push File.expand_path("../lib", __FILE__)

require "active_record_batteries/version"

Gem::Specification.new do |s|
  s.name        = "active_record_batteries"
  s.version     = ActiveRecordBatteries::VERSION
  s.authors     = ["Francisco Soto"]
  s.email       = ["ebobby@ebobby.org"]
  s.homepage    = "https://github.com/ebobby/active_record_batteries"
  s.summary     = "ActiveRecord with Batteries. Extensions to make life easier."
  s.description = "Several small active record modules to empower models in a simple way."
  s.license     = "MIT"

  s.files      = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency             "rails", "~> 5"
  s.add_development_dependency "sqlite3", "~> 1.3.10"
  s.add_development_dependency "rspec-rails"
end
