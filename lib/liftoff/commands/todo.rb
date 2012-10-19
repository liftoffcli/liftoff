require 'xcodeproj'

TODO_WARNING_SCRIPT = <<WARNING
KEYWORDS="TODO:|FIXME:|\\?\\?\\?:|\\!\\!\\!:"
find "${SRCROOT}" \\( -name "*.h" -or -name "*.m" \\) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\\$" | perl -p -e "s/($KEYWORDS)/ warning: \\$1/"
WARNING

XCODE_PROJECT_PATH = Dir.glob("*.xcodeproj")

command :todo do |c|
	c.syntax = 'liftoff todo [options]'
	c.summary = 'Add a build script to treat TODO and FIXME as warnings.'
	c.description = ''
	
	c.action do |args, options|
		add_shell_script
	end
	
	private
	
	def add_shell_script
		find_target
		@target.shell_script_build_phases.new('name' => 'Warn for TODO and FIXME comments', 'shellScript' => TODO_WARNING_SCRIPT)
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