require 'xcodeproj'

module Liftoff
  class XcodeprojHelper
    def initialize(name)
      @project = Xcodeproj::Project.open("#{name}.xcodeproj")
    end

    def treat_warnings_as_errors(enable_errors)
      if enable_errors
        say 'Setting GCC_TREAT_WARNINGS_AS_ERRORS for Release builds'
        target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
        @project.save
      end
    end

    def enable_warnings(warnings)
      if warnings
        say 'Setting warnings at the project level'
        @project.build_configurations.each do |configuration|
          warnings.each do |warning|
            configuration.build_settings[warning] = 'YES'
          end
        end
        @project.save
      end
    end

    def enable_static_analyzer(enable_static_analyzer)
      if enable_static_analyzer
        say 'Turning on Static Analyzer at the project level'
        @project.build_configurations.each do |configuration|
          configuration.build_settings['RUN_CLANG_STATIC_ANALYZER'] = 'YES'
        end
        @project.save
      end
    end

    def set_indentation_level(level)
      if level
        say "Setting the project indentation level to #{level} spaces"
        main_group = @project.main_group
        main_group.indent_width = level.to_s
        main_group.tab_width = level.to_s
        main_group.uses_tabs = '0'
        @project.save
      end
    end

    def add_todo_script_phase(enable_todos)
      if enable_todos
        say 'Adding shell script build phase to warn on TODO and FIXME comments'
        add_shell_script_build_phase(file_manager.template_contents('todo.sh'), 'Warn for TODO and FIXME comments')
      end
    end

    private

    def target
      @project_target ||= choose_item("target", available_targets)
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
      @project.targets.to_a.reject { |t| t.name.end_with?('Tests') }
    end

    def add_shell_script_build_phase(script, name)
      if build_phase_does_not_exist_with_name?(name)
        build_phase = target.new_shell_script_build_phase(name)
        build_phase.shell_script = script
        @project.save
      end
    end

    def build_phase_does_not_exist_with_name?(name)
      target.build_phases.to_a.none? { |phase| phase.display_name == name }
    end

    def file_manager
      @file_manager ||= FileManager.new
    end
  end
end
