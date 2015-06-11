module Liftoff
  class DependencyManagerCoordinator
    def initialize(dependencies)
      @dependencies = dependencies
    end

    def setup_dependencies
      dependencies.map(&:setup)
    end

    def install_dependencies
      dependencies.map(&:install)
    end

    def run_script_phases_for_dependencies
      dependencies.map(&:run_script_phases).flatten
    end

    private

    attr_reader :dependencies
  end
end
