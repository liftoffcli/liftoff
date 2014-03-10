require 'fileutils'

module Liftoff
  class FileManager
    def create_project_dir(name, &block)
      FileUtils.mkdir(name)
      Dir.chdir(name, &block)
    end

    def generate(template, destination = template, project_config = ProjectConfiguration.new({}))
      puts "Writing #{destination}"
      if template_is_directory?(template)
        copy_template_directory(template, destination)
      else
        existing_content = existing_file_contents(destination)
        move_template(template, destination, project_config)
        append_original_file_contents(destination, existing_content)
      end
    end

    def mkdir_gitkeep(path)
      dir_path = File.join(*path)
      puts "Creating #{dir_path}"
      FileUtils.mkdir_p(dir_path)
      FileUtils.touch(File.join(dir_path, '.gitkeep'))
    end

    def template_contents(filename)
      user_file_path = File.join(user_templates_dir, filename)
      if File.exists? user_file_path
        file_path = user_file_path
      else
        file_path = File.join(templates_dir, filename)
      end
      File.read(file_path)
    end

    def copy_template_directory(name, path)
      directory = File.join(templates_dir, name)
      FileUtils.cp_r(directory, File.join(*path))
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
      rendered_template = StringRenderer.new(project_config).render(template_contents(template))

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

    def template_is_directory?(template)
      File.directory?(File.join(templates_dir, template))
    end

    def templates_dir
      File.expand_path('../../../templates', __FILE__)
    end

    def user_templates_dir
      File.expand_path(ENV['HOME'] + '/.liftoff', __FILE__)
    end
  end
end
