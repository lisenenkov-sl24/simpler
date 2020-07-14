require_relative 'config/environment'
require_relative 'lib/simple_logger'

use SimpleLogger
run Simpler.application
