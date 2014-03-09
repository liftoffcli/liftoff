module Liftoff
  class CocoapodsHelper

    def initialize(project_configuration)
      @project_configuration = project_configuration
    end

    def install_cocoapods(enable_cocoapods)
      if enable_cocoapods
        if pod_installed?
          move_podfile
          add_pods
          run_pod_install
        else
          puts 'Please install Cocoapods or disable pods from liftoff'
        end
      end
    end

    private

    def pod_installed?
      `which pod`
      $?.success?
    end

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
      system('pod install')
    end

  end
end
