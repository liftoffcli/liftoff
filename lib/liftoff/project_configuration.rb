module Liftoff
  class ProjectConfiguration
    LATEST_IOS = 7.0

    attr_accessor :project_name, :company, :prefix, :configure_git, :warnings_as_errors, :install_todo_script, :enable_static_analyzer, :indentation_level, :warnings, :application_target_groups, :unit_test_target_groups, :use_cocoapods
    attr_writer :author, :company_identifier, :use_tabs

    def initialize(liftoffrc)
      liftoffrc.each_pair do |attribute, value|
        if respond_to?("#{attribute}=")
          send("#{attribute}=", value)
        else
          STDERR.puts "Unknown key #{attribute} found in liftoffrc!"
          exit 1
        end
      end
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

    def get_binding
      binding
    end

    private

    def normalized_company_name
      company.gsub(/[^0-9a-z]/i, '').downcase
    end
  end
end
