module Liftoff
  class ProjectConfiguration
    LATEST_IOS = 8.0

    attr_accessor :project_name,
      :company,
      :prefix,
      :configure_git,
      :warnings_as_errors,
      :enable_static_analyzer,
      :indentation_level,
      :warnings,
      :templates,
      :application_target_groups,
      :unit_test_target_groups,
      :use_cocoapods,
      :run_script_phases,
      :strict_prompts,
      :xcode_command,
      :extra_config

    attr_writer :author,
      :company_identifier,
      :use_tabs

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

    def deployment_target
      LATEST_IOS
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

    private

    def normalized_company_name
      company.gsub(/[^0-9a-z]/i, '').downcase
    end
  end
end
