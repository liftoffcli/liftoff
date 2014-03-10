module Liftoff
  class TemplateFinder
    def template_path(name)
      local_template(name) || user_template(name) || default_template(name)
    end

    private

    def local_template(name)
      path_for_file(File.expand_path('../'), name)
    end

    def user_template(name)
      path_for_file(ENV['HOME'], name)
    end

    def default_template(name)
      File.join(templates_dir, name)
    end

    def path_for_file(location, name)
      path = File.join(location, '.liftoff', 'templates', name)
      if File.exists?(path)
        path
      end
    end

    def templates_dir
      File.expand_path('../../../templates', __FILE__)
    end
  end
end
