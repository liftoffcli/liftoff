require 'xcodeproj'

TODO_WARNING_SCRIPT = <<WARNING
KEYWORDS="TODO:|FIXME:|\\?\\?\\?:|\\!\\!\\!:"
FILE_EXTENSIONS="h|m|mm|c|cpp"
find -E "${SRCROOT}" -ipath "${SRCROOT}/pods" -prune -o \\( -regex ".*\\.($FILE_EXTENSIONS)$" \\) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\\$" | perl -p -e "s/($KEYWORDS)/ warning: \\$1/"
WARNING

module Liftoff
  class XcodeprojHelper
    XCODE_PROJECTS = Dir.glob("*.xcodeproj")

    def initialize(project_configuration)
      @project = Xcodeproj::Project.open(xcode_project_file)
      @target = project_target
      @project_configuration = project_configuration
    end

    def treat_warnings_as_errors
      say 'Setting GCC_TREAT_WARNINGS_AS_ERRORS for Release builds'
      @target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
      save_changes
    end

    def enable_warnings
      say 'Setting warnings at the project level'
      @project.build_configurations.each do |configuration|
        @project_configuration[:warnings].each do |setting|
          configuration.build_settings[setting] = 'YES'
        end
      end
      save_changes
    end

    def enable_static_analyzer
      say 'Turning on Static Analyzer at the project level'
      @project.build_configurations.each do |configuration|
        configuration.build_settings['RUN_CLANG_STATIC_ANALYZER'] = 'YES'
      end
      save_changes
    end

    def set_indentation_level(level)
      say "Setting the project indentation level to #{level} spaces"
      main_group = @project.main_group
      main_group.indent_width = level.to_s
      main_group.tab_width = level.to_s
      main_group.uses_tabs = '0'
      save_changes
    end

    def add_todo_script_phase
      say 'Adding shell script build phase to warn on TODO and FIXME comments'
      add_shell_script_build_phase(TODO_WARNING_SCRIPT, 'Warn for TODO and FIXME comments')
    end

    private

    def project_target
      @project_target ||= choose_item("target", available_targets)
    end

    def xcode_project_file
      @xcode_project_file ||= choose_item('Xcode project', XCODE_PROJECTS)

      if @xcode_project_file == 'Pods.xcodeproj'
        raise 'Can not run in the Pods directory. $ cd .. maybe?'
      end

      @xcode_project_file
    end

    def choose_item(title, objects)
      if objects.empty?
        raise "Could not locate any #{title}s!"
      elsif objects.size == 1
        objects.first
      else
        choose("Which #{title} would you like to modify?") do |menu|
          menu.index = :number
          objects.map { |object| menu.choice(object) }
        end
      end
    end

    def available_targets
      @project.targets.to_a.delete_if { |t| t.name.end_with?('Tests') }
    end

    def add_shell_script_build_phase(script, name)
      unless build_phase_exists_with_name name
        build_phase = @target.new_shell_script_build_phase(name)
        build_phase.shell_script = script
        save_changes
      end
    end

    def build_phase_exists_with_name(name)
      @target.build_phases.to_a.index { |phase| phase.display_name == name }
    end

    def save_changes
      @project.save xcode_project_file
    end
  end
end
