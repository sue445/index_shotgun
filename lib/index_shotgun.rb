require "index_shotgun/version"
require "index_shotgun/analyzer"

# FIXME: NameError: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger when activesupport < 7.1
require "logger"

require "active_record"

module IndexShotgun
  # Your code goes here...
end

require "index_shotgun/railtie" if defined?(Rails)
