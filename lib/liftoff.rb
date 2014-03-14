require 'optparse'
require 'fileutils'
require 'yaml'
require 'erb'
require 'etc'

require 'highline/import'
require 'xcodeproj'

require 'liftoff/cli'
require 'liftoff/cocoapods_setup'
require 'liftoff/configuration_parser'
require 'liftoff/file_manager'
require 'liftoff/git_setup'
require 'liftoff/launchpad'
require 'liftoff/object_picker'
require 'liftoff/option_fetcher'
require 'liftoff/project'
require 'liftoff/project_builder'
require 'liftoff/project_configuration'
require 'liftoff/string_renderer'
require 'liftoff/template_finder'
require 'liftoff/version'
require 'liftoff/xcodeproj_helper'
