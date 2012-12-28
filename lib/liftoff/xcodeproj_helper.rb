require 'xcodeproj'

TODO_WARNING_SCRIPT = <<WARNING
KEYWORDS="TODO:|FIXME:|\\?\\?\\?:|\\!\\!\\!:"
find "${SRCROOT}" -ipath "${SRCROOT}/pods" -prune -o \\( -name "*.h" -or -name "*.m" \\) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\\$" | perl -p -e "s/($KEYWORDS)/ warning: \\$1/"
WARNING

class XcodeprojHelper
  XCODE_PROJECT_PATH = Dir.glob("*.xcodeproj")

  def initialize
    @project = Xcodeproj::Project.new(xcode_project_file)
    @target = project_target
  end

  def treat_warnings_as_errors
    say 'Setting GCC_TREAT_WARNINGS_AS_ERRORS for Release builds'
    @target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
    save_changes
  end

  def enable_all_warnings
    say 'Setting -Wall for all builds'
    @target.build_configurations.each do |configuration|
      configuration.build_settings['WARNING_CFLAGS'] = '-Wall'
    end
    save_changes
  end

  def set_indentation_level(level)
    say "Setting the project indentation level to #{level} spaces"
    project_attributes = @project.main_group.attributes
    project_attributes['indentWidth'] = level
    project_attributes['tabWidth'] = level
    project_attributes['usesTabs'] = 0
    save_changes
  end

  def add_todo_script_phase
    say 'Adding shell script build phase to warn on TODO and FIXME comments'
    add_shell_script_build_phase(TODO_WARNING_SCRIPT, 'Warn for TODO and FIXME comments')
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

  def add_shell_script_build_phase(script, name)
    unless build_phase_exists_with_name name
      @target.shell_script_build_phases.new('name' => name, 'shellScript' => script)
      save_changes
    end
  end

  def build_phase_exists_with_name(name)
    @target.build_phases.to_a.index { |phase| phase.name == name }
  end

  def save_changes
    @project.save_as xcode_project_file
  end
end
