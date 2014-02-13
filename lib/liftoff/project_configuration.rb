module Liftoff
  class ProjectConfiguration
    attr_accessor :name, :company, :author, :prefix, :git, :errors, :todo, :staticanalyzer, :indentation, :warnings, :directories

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
