require 'rspec/core/rake_task'
require 'rake/packagetask'

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'liftoff/version'

namespace :bundle do
  desc 'Install distribution dependencies'
  task :deploy do
    `bundle install --path=vendor --without test`
  end

  desc 'Install development dependencies'
  task :development do
    FileUtils.rm('.bundle/config')
    `bundle install --path=vendor`
  end

  desc 'Clear the installed dependencies'
  task :clean do
    FileUtils.rm_r(Dir.glob('vendor/*'))
  end
end

desc 'Create new distribution tarball'
task :create_distribution => ['bundle:clean', 'bundle:deploy', :package]

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

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

task :default => :spec
