require 'rspec/core/rake_task'
require 'rake/packagetask'

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'liftoff/version'

desc 'run bundle install'
task :bundle do
  `bundle install --path=vendor --without test`
end

desc 'clean the vendor dir'
task :bundle_clean do
  `rm -r vendor/*`
end

desc 'create new distribution tarball'
task :create_distribution => [:bundle_clean, :bundle, :package]

desc 'Runs the tests for the project'
RSpec::Core::RakeTask.new(:spec)

Rake::PackageTask.new('Liftoff', Liftoff::VERSION) do |p|
  p.need_tar_gz = true
  p.package_files.include('bin/**/*')
  p.package_files.include('defaults/**/*')
  p.package_files.include('lib/**/*')
  p.package_files.include('templates/**/*')
  p.package_files.include('vendor/**/*')
  p.package_files.include('LICENSE.txt')
end

task :default => :spec
