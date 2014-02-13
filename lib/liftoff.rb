require 'pathname'
file_path = Pathname.new(__FILE__).realpath

vendored_gems = File.expand_path('../../vendor/**/{lib,ext}/', file_path)
libdirs = Dir.glob(vendored_gems)

libdirs.each do |libdir|
  $LOAD_PATH.unshift(libdir)
end

require 'highline/import'
require 'liftoff/cli'
require 'liftoff/version'
require 'liftoff/xcodeproj_helper'
require 'liftoff/file_manager'
require 'liftoff/git_setup'
require 'liftoff/configuration_parser'
require 'liftoff/project_builder'
require 'liftoff/project_configuration'
require 'liftoff/launchpad'
