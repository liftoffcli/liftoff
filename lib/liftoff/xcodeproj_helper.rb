require 'xcodeproj'

class XcodeprojHelper

  XCODE_PROJECT_PATH = Dir.glob("*.xcodeproj")

  def initialize
    @project = Xcodeproj::Project.new(xcode_project_file)
    @target = project_target
  end

  def add_shell_script(script)
    @target.shell_script_build_phases.new('name' => 'Warn for TODO and FIXME comments', 'shellScript' => script)
    save_changes
  end

  def treat_warnings_as_errors
    @target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
    save_changes
  end

  def enable_all_warnings
    @target.build_configurations.each do |configuration|
      configuration.build_settings['WARNING_CFLAGS'] = '-Wall'
    end
    save_changes
  end

  private

  def project_target
    if @project_target.nil?
      available_targets = @project.targets.to_a
      available_targets.delete_if { |t| t.name =~ /Tests$/ }
      @project_target = available_targets.first

      if @project_target.nil?
        raise 'Could not locate a target in the given project.'
      end
    end

    @project_target
  end

  def xcode_project_file
    @xcode_project_file ||= XCODE_PROJECT_PATH.first

    if @xcode_project_file.nil?
       raise 'Can not run in a directory without an .xcodeproj file'
    end

    @xcode_project_file
  end

  def save_changes
    @project.save_as xcode_project_file
  end

end
