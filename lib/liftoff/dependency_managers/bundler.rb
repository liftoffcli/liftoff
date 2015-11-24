module Liftoff
  class Bundler < DependencyManager
    def setup
      if bundler_installed?
        move_gemfile
      else
        puts "Please install Bundler or disable bundler from liftoff"
      end
    end

    def install
      if bundler_installed?
        run_bundle_install
      end
    end

    private

    def bundler_installed?
      system("which bundle > /dev/null")
    end

    def move_gemfile
      FileManager.new.generate("Gemfile.rb", "Gemfile", config)
    end

    def run_bundle_install
      puts "Running bundle install"
      system("bundle install")
    end
  end
end
