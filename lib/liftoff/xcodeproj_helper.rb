module Liftoff
  class XcodeprojHelper
    LAST_INDEX = -1

    def initialize(config)
      @test_target_name = config.test_target_name
    end

    def treat_warnings_as_errors(enable_errors)
      if enable_errors
        puts 'Setting GCC_TREAT_WARNINGS_AS_ERRORS for Release builds'
        application_target.build_settings('Release')['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
      end
    end

    def enable_warnings(warnings)
      if warnings
        puts 'Setting warnings at the project level'
        xcode_project.build_configurations.each do |configuration|
          warnings.each do |warning|
            configuration.build_settings[warning] = 'YES'
          end
        end
      end
    end

    def enable_static_analyzer(enable_static_analyzer)
      if enable_static_analyzer
        puts 'Turning on Static Analyzer at the project level'
        xcode_project.build_configurations.each do |configuration|
          configuration.build_settings['RUN_CLANG_STATIC_ANALYZER'] = 'YES'
        end
      end
    end

    def set_indentation_level(level, use_tabs)
      if level
        puts "Setting the project indentation level to #{level}"
        main_group = xcode_project.main_group
        main_group.indent_width = level.to_s
        main_group.tab_width = level.to_s
        main_group.uses_tabs = use_tabs
      end
    end

    def add_script_phases(scripts)
      if scripts
        scripts.each do |script|

          file = script['file']
          name = script['name']
          index = script.fetch('index', LAST_INDEX)

          puts "Adding shell script build phase '#{name}'"
          add_shell_script_build_phase(file_manager.template_contents(file), name, index)
        end
      end
    end

    def perform_extra_config(app_config, test_config)
      {app_config => application_target, test_config => test_target}.each do |config, target|
        if config
          config.each do |name, settings|
            if name.downcase == "all"
              object = target
            else
              object = target.build_settings(name)
            end

            if object
              object.merge!(settings)
            end
          end
        end
      end
    end

    def save
      xcode_project.save
    end

    private

    def application_target
      @target ||= ObjectPicker.choose_item('target', application_targets)
    end

    def test_target
      @test_target ||= ObjectPicker.choose_item('test target', test_targets)
    end

    def application_targets
      all_targets.reject { |t| t.name == @test_target_name }
    end

    def test_targets
      all_targets.select { |t| t.name == @test_target_name }
    end

    def all_targets
      xcode_project.targets.to_a
    end

    def add_shell_script_build_phase(script, name, index)
      if build_phase_does_not_exist_with_name?(name)
        build_phase = application_target.new_shell_script_build_phase(name)
        build_phase.shell_script = script

        application_target.build_phases.delete(build_phase)
        application_target.build_phases.insert(index, build_phase)

        xcode_project.save
      end
    end

    def build_phase_does_not_exist_with_name?(name)
      application_target.build_phases.to_a.none? { |phase| phase.display_name == name }
    end

    def file_manager
      @file_manager ||= FileManager.new
    end

    def xcode_project
      @xcode_project ||= Xcodeproj::Project.open(project_file)
    end

    def project_file
      @project_file ||= ObjectPicker.choose_item('project', Dir.glob('*.xcodeproj'))
    end
  end
end
