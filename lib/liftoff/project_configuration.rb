module Liftoff
  class ProjectConfiguration
    attr_accessor :project_name, :company, :author, :prefix, :configure_git, :warnings_as_errors, :install_todo_script, :enable_static_analyzer, :indentation_level, :warnings, :application_target_groups, :unit_test_target_groups, :use_cocoapods
    attr_writer :company_identifier

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

    def company_identifier
      @company_identifier || "com.#{normalized_company_name}"
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
