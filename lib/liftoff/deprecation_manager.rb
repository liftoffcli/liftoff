module Liftoff
  class DeprecationManager
    DEPRECATIONS = {
      :install_todo_script => 'run_script_phases',
      :use_cocoapods => 'dependency_managers',
    }

    def initialize
      @errors = false
    end

    def handle_key(key)
      replacement = DEPRECATIONS[key]

      if replacement
        STDERR.puts "Deprecated key '#{key}' found in liftoffrc!"
        STDERR.puts "Please use the new key: #{replacement}"
      else
        STDERR.puts "Unknown key '#{key}' found in liftoffrc!"
      end

      @errors = true
    end

    def finish
      if @errors
        exit 1
      end
    end
  end
end
