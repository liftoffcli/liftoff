module Liftoff
  class FileManager
    def create_project_dir(name, &block)
      FileUtils.mkdir(name)
      Dir.chdir(name, &block)
    rescue Errno::EEXIST
      STDERR.puts "Directory '#{name}' already exists"
      exit 1
    end

    def move_scheme(project_name)
      shared_schemes = "#{project_name}.xcodeproj/xcshareddata/xcschemes"
      original_scheme = Dir.glob("**/#{project_name}.xcscheme").first
      FileUtils.mkdir_p(shared_schemes)
      FileUtils.mv(original_scheme, shared_schemes)
    end

    def generate(template, destination = template, project_config = ProjectConfiguration.new({}))
      puts "Writing #{destination}"
      template_path = TemplateFinder.new.template_path(template)
      if template_is_directory?(template_path)
        copy_template_directory(template_path, destination)
      else
        create_template_file(destination, template_path, project_config)
      end
    end

    def mkdir_gitkeep(path)
      dir_path = File.join(*path)
      puts "Creating #{dir_path}"
      FileUtils.mkdir_p(dir_path)
      FileUtils.touch(File.join(dir_path, '.gitkeep'))
    end

    def template_contents(filename)
      file_path = TemplateFinder.new.template_path(filename)
      File.read(file_path)
    end

    private

    def create_template_file(destination, template_path, project_config)
      existing_content = existing_file_contents(destination)
      move_template(template_path, destination, project_config)
      append_original_file_contents(destination, existing_content)
      if File.executable?(template_path)
        File.chmod(0755, destination)
      end
    end

    def copy_template_directory(template, path)
      FileUtils.cp_r(template, File.join(*path))
    end

    def existing_file_contents(filename)
      if File.exists? filename
        puts "#{filename} already exists!"
        puts 'We will append the contents of the existing file to the end of the template'
        File.read(filename)
      end
    end

    def move_template(template, destination, project_config)
      rendered_template = StringRenderer.new(project_config).render(File.read(template))

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

    def template_is_directory?(template_path)
      File.directory?(template_path)
    end
  end
end
