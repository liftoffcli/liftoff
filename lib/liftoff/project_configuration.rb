module Liftoff
  class ProjectConfiguration
    attr_accessor :project_name, :company, :author, :prefix, :configure_git, :warnings_as_errors, :install_todo_script, :enable_static_analyzer, :indentation_level, :warnings, :application_target_groups, :unit_test_target_groups, :use_pods, :pods

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

    def get_binding
      binding
    end
  end
end
