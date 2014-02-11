module Liftoff
  class ProjectConfiguration
    attr_accessor :git, :error, :todo, :staticanalyzer, :indentation, :warnings, :directories

    def initialize(hash)
      hash.each_pair do |attr, val|
        if respond_to?("#{attr}=")
          send("#{attr}=", val)
        else
          STDERR.puts "Unknown key #{attr} found in liftoffrc!"
          exit 1
        end
      end
    end
  end
end
