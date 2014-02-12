require 'fileutils'

module Liftoff
  class FileManager
    def create_git_files(generate_git)
      if generate_git
        generate('gitignore', '.gitignore')
        generate('gitattributes', '.gitattributes')
      end
    end

    private

    def generate(template, destination = template)
      puts "Writing #{destination}"
      existing_content = existing_file_contents(destination)

      move_template(template, destination)

      append_original_file_contents(destination, existing_content)
    end

    def existing_file_contents(filename)
      if File.exists? filename
        puts "#{filename} already exists!"
        puts 'We will append the contents of the existing file to the end of the template'
        File.read(filename)
      end
    end

    def move_template(template, destination)
      template_path = File.join(templates_dir, template)
      FileUtils.copy(template_path, destination, {})
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
