#!/usr/bin/env ruby
#
# This is a stub of the liftoff executable for development purposes.
# The actual executable is located at src/liftoff

require 'optparse'
require 'fileutils'
require 'yaml'
require 'erb'
require 'etc'
require 'find'

require 'highline/import'
require 'xcodeproj'

require 'liftoff/build_configuration_builder'
require 'liftoff/cli'
require "liftoff/dependency_manager_coordinator"
require "liftoff/dependency_manager"
require "liftoff/dependency_managers/bundler"
require "liftoff/dependency_managers/carthage"
require "liftoff/dependency_managers/cocoapods"
require "liftoff/dependency_managers/null_dependency_manager"
require 'liftoff/swiftlint_setup'
require 'liftoff/settings_generator'
require 'liftoff/configuration_parser'
require 'liftoff/deprecation_manager'
require 'liftoff/file_manager'
require 'liftoff/git_setup'
require 'liftoff/launchpad'
require 'liftoff/object_picker'
require 'liftoff/option_fetcher'
require 'liftoff/project'
require 'liftoff/project_builder'
require 'liftoff/project_configuration'
require 'liftoff/scheme_builder'
require 'liftoff/string_renderer'
require 'liftoff/template_finder'
require 'liftoff/template_generator'
require 'liftoff/version'
require 'liftoff/xcodeproj_helper'
require 'liftoff/xcodeproj_monkeypatch'
