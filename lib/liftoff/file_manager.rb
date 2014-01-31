require 'fileutils'

class FileManager
  def create_git_files
    generate('gitignore', '.gitignore')
    generate('gitattributes', '.gitattributes')
  end

  private

  def generate(template, destination = template)
    puts "Writing #{destination}"
    existing_content = existing_file_contents(destination)

    move_template(template, destination)

    if existing_content
      append_original_file_contents(destination, existing_content)
    end
  end

  def existing_file_contents(filename)
    if File.exists? filename
      puts "#{filename} already exists!"
      puts 'We will append the contents of the existing file to the end of the template'
      File.read(filename)
    end
  end

  def move_template(template, destination)
    template_path = "#{lib_dir}/templates/#{template}"
    FileUtils.copy(template_path, destination, {})
  end

  def append_original_file_contents(filename, original_contents)
    File.open(filename, 'a') do |file|
      file.write("\n# Original #{filename} contents\n")
      file.write(original_contents)
    end
  end

  def lib_dir
    @lib_dir ||= File.expand_path(File.dirname(File.dirname(__FILE__)))
  end
end
