require 'xcodeproj'

XCODE_PROJECT_PATH = Dir.glob("*.xcodeproj")

command :releasewarnings do |c|
	c.syntax = 'liftoff releasewarnings [options]'
	c.summary = 'Treat all warnings as errors in release schemes.'
	c.description = ''

	c.action do |args, options|
		treat_warnings_as_errors
	end
	
	private
	
	def treat_warnings_as_errors
		find_target
		@target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
		save_changes
	end
	
	def find_target
		find_project
		available_targets = @project.targets.to_a
		available_targets.delete_if { |t| t.name =~ /Tests$/ }
		@target = available_targets.first
	end
	
	def find_project
		@project = Xcodeproj::Project.new(xcode_project_file)
	end

	def xcode_project_file
		XCODE_PROJECT_PATH.first
	end

	def save_changes
		@project.save_as xcode_project_file
	end
end