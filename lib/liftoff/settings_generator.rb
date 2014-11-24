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
      parent_group = xcode_project[@config.project_name]['Resources']
      if (parent_group)
        settings_bundle_path = "#{@config.project_name}/Resources/Settings.bundle"
      else
        parent_group = xcode_project[@config.project_name]

        if (parent_group)
          settings_bundle_path = "#{@config.project_name}/Settings.bundle"
        else
          parent_group = xcode_project.main_group

          if (parent_group)
            settings_bundle_path = 'Settings.bundle'
          end
        end
      end

      if (parent_group)
        FileManager.new.generate('Settings.bundle', settings_bundle_path, @config)
        file_reference = parent_group.new_file('Settings.bundle')
        target.add_resources([file_reference])
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
