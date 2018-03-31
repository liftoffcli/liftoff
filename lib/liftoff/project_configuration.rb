module Liftoff
  class ProjectConfiguration
    attr_accessor :project_name,
      :company,
      :prefix,
      :test_target_name,
      :configure_git,
      :enable_settings,
      :warnings_as_errors,
      :enable_static_analyzer,
      :indentation_level,
      :warnings,
      :templates,
      :project_template,
      :app_target_templates,
      :test_target_templates,
      :dependency_managers,
      :run_script_phases,
      :strict_prompts,
      :xcode_command,
      :extra_config,
      :extra_test_config,
      :deployment_target,
      :schemes,
      :build_configurations,
      :swift_version

    attr_writer :author,
      :company_identifier,
      :use_tabs,
      :path

    def initialize(liftoffrc)
      deprecations = DeprecationManager.new
      liftoffrc.each_pair do |attribute, value|
        if respond_to?("#{attribute}=")
          send("#{attribute}=", value)
        else
          deprecations.handle_key(attribute)
        end
      end

      deprecations.finish
    end

    def author
      @author || Etc.getpwuid.gecos.split(',').first
    end

    def company_identifier
      @company_identifier || "com.#{normalized_company_name}"
    end

    def use_tabs
      if @use_tabs
        '1'
      else
        '0'
      end
    end

    def each_template(&block)
      return enum_for(__method__) unless block_given?

      templates.each do |template|
        template.each_pair(&block)
      end
    end

    def get_binding
      binding
    end

    def app_target_groups
      @app_target_templates[@project_template]
    end

    def test_target_groups
      @test_target_templates[@project_template]
    end

    def path
      @path || project_name
    end

    def dependency_manager_enabled?(name)
      dependency_managers.include?(name)
    end

    private

    def normalized_company_name
      company.force_encoding('UTF-8').gsub(/[^0-9a-z]/i, '').downcase
    end
  end
end
