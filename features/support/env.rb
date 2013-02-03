$LOAD_PATH.unshift(File.expand_path('../../../lib', __FILE__))
require 'cucumber'
require 'aruba/cucumber'
require 'flabbergast'

Before do
  @dirs = ["/tmp/flabbergast_features"]
end
