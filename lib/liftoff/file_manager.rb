require 'fileutils'
require 'erb'

module Liftoff
  class FileManager
    def create_git_files(generate_git)
      if generate_git
        generate('gitignore', '.gitignore')
        generate('gitattributes', '.gitattributes')
      end
    end

    def create_project_dir(name, &block)
      FileUtils.mkdir(name)
      Dir.chdir(name) do
        yield
      end
    end

    def generate(template, destination = template, project_config = ProjectConfiguration.new({}))
      puts "Writing #{destination}"
      existing_content = existing_file_contents(destination)

      move_template(template, destination, project_config)

      append_original_file_contents(destination, existing_content)
    end

    def mkdir_gitkeep(path)
      dir_path = File.join(*path)
      FileUtils.mkdir_p(dir_path)
      FileUtils.touch(File.join(dir_path, '.gitkeep'))
    end

    def template_contents(filename)
      script_path = File.join(templates_dir, filename)
      File.read(script_path)
    end

    private

    def existing_file_contents(filename)
      if File.exists? filename
        puts "#{filename} already exists!"
        puts 'We will append the contents of the existing file to the end of the template'
        File.read(filename)
      end
    end

    def move_template(template, destination, project_config)
      rendered_template = ERB.new(template_contents(template)).result(project_config.get_binding)

      File.open(destination, 'w') do |file|
        file.write(rendered_template)
      end
    end

    def append_original_file_contents(filename, original_contents)
      if original_contents
        File.open(filename, 'a') do |file|
          file.write("\n# Original #{filename} contents\n")
          file.write(original_contents)
        end
      end
    end

    def templates_dir
      File.expand_path('../../../templates', __FILE__)
    end
  end
end
