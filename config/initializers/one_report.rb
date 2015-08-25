require 'refile'
OneReport::Engine.config.paths['db/migrate'].expanded.each do |path|
  Rails.configuration.paths["db/migrate"].push(path)
end

OneReport::Engine.config.paths['config/locales'].expanded.each do |path|
  Rails.configuration.paths['config/locales'].push(path)
end


