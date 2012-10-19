require 'xcodeproj'

command :warnings do |c|
	c.syntax = 'liftoff warnings [options]'
	c.summary = 'Enable all warnings.'
	c.description = ''
	
	c.action do |args, options|
		enable_all_warnings
	end
	
	private
	
	def enable_all_warnings
		find_target
		@target.build_configurations.each do |configuration|
			configuration.build_settings['WARNING_CFLAGS'] = '-Wall'
		end
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