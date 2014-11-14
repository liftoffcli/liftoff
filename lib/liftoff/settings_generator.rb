module Liftoff
  class SettingsGenerator
    def initialize(config)
      @config = config
    end

    def generate
      if @config.enable_settings
        move_settings_bundle
      end
    end

    def move_settings_bundle
      FileManager.new.generate('Settings.bundle', 'Resources/Settings.bundle', @config)
      parent_group = xcode_project['Resources'] || xcode_project.main_group
      if (parent_group)
        file = parent_group.new_file('Settings.bundle')
        target.add_resources([file])
        xcode_project.save
      end
    end

    private

    def available_targets
      xcode_project.targets.to_a.reject { |t| t.name.end_with?('Tests') }
    end

    def target
      @target ||= ObjectPicker.choose_item('target', available_targets)
    end

    def xcode_project
      @xcode_project ||= Xcodeproj::Project.open(project_file)
    end

    def project_file
      @project_file ||= ObjectPicker.choose_item('project', Dir.glob('*.xcodeproj'))
    end

  end
end
