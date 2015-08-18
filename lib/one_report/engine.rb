require 'rubygems'
require 'prawn/table'
require 'refile'
require 'refile/rails'
require 'sprockets/railtie'

module OneReport
  class Engine < ::Rails::Engine
    #config.assets.precompile += ['one_report/application.js']
    #config.assets.precompile += ['one_report/application.css']
  end
end

