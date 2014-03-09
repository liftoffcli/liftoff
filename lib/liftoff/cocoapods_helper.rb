module Liftoff
  class CocoapodsHelper

  	def initialize(project_configuration)
      @project_configuration = project_configuration
    end

  	def install_cocoapods(enable_cocoapods)
  		if enable_cocoapods
  			puts 'Installing Cocoapods'
	  		move_podfile
	  		run_pod_install
  		end
  	end

  	private

  	def move_podfile
      FileManager.new.generate('Podfile', 'Podfile', @project_configuration)
    end

    def run_pod_install
    	`pod install`
    end

  end
end
