require 'rspec/core/rake_task'
require 'rake/packagetask'

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'liftoff/version'

namespace :gems do
  desc 'Vendorize dependencies'
  task :vendorize do
    system('vendor/vendorize vendor/gems/')
  end

  desc 'Remove vendorized dependencies'
  task :clean do
    FileUtils.rm_r('vendor/gems/')
  end
end

Rake::PackageTask.new('Liftoff', Liftoff::VERSION) do |p|
  p.need_tar_gz = true
  p.package_files.include('bin/**/*')
  p.package_files.include('defaults/**/*')
  p.package_files.include('lib/**/*')
  p.package_files.include('templates/**/*')
  p.package_files.include('vendor/**/*')
  p.package_files.include('man/**/*')
  p.package_files.include('LICENSE.txt')
end

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
