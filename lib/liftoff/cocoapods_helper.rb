module Liftoff
  class CocoapodsHelper

    def initialize(project_configuration)
      @project_configuration = project_configuration
    end

    def install_cocoapods(enable_cocoapods)
      if enable_cocoapods
        move_podfile
        add_pods
        puts 'Installing Cocoapods'
        run_pod_install
      end
    end

    private

    def move_podfile
      FileManager.new.generate('Podfile', 'Podfile', @project_configuration)
    end

    def add_pods
      if @project_configuration.pods
        File.open('Podfile', 'a') do |file|
          file.write("\n")
          @project_configuration.pods.each do |pod|
            puts "Adding #{pod} to Podfile"
            file.write("pod '#{pod}'\n")
          end
        end
      end
    end

    def run_pod_install
      `pod install`
    end

  end
end
