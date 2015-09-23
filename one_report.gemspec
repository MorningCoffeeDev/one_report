$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "one_report/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "one_report"
  s.version     = OneReport::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "https://github.com/MorningCoffeeDev/one_report"
  s.summary     = "Summary of OneReport."
  s.description = "Description of OneReport."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency 'refile', '~> 0.6.1'
  s.add_dependency 'prawn-table'
end
