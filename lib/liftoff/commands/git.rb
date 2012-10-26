GITIGNORE_CONTENTS = <<GITIGNORE
# OS X Finder
.DS_Store

# Xcode per-user config
*.mode1
*.mode1v3
*.mode2v3
*.perspective
*.perspectivev3
*.pbxuser
*.xcworkspace
xcuserdata

# Build products
build/
*.o
*.LinkFileList
*.hmap

# Automatic backup files
*~.nib/
*.swp
*~
*.dat
*.dep
GITIGNORE

GITATTRIBUTES_CONTENTS = "*.pbxproj binary merge=union"

command :git do |c|
  c.syntax = 'liftoff git [options]'
  c.summary = 'Add default .gitignore and .gitattributes files.'
  c.description = ''

  c.action do |args, options|
    if Dir["*.xcodeproj"].empty?
      puts "Could not find an Xcode project file. You need to run me from a valid project directory."
      exit
    end

    generate_files
  end

  private

  def generate_files
    generate_gitignore
    generate_gitattributes
  end

  def generate_gitignore
    write_unique_contents_to_file(GITIGNORE_CONTENTS, '.gitignore')
  end

  def generate_gitattributes
    write_unique_contents_to_file(GITATTRIBUTES_CONTENTS, '.gitattributes')
  end

  def write_unique_contents_to_file(contents, filename)
    if File.exists? filename
      current_file_contents = File.read(filename).split("\n")
    else
      current_file_contents = []
    end

    new_contents = current_file_contents + contents.split("\n")

    File.open(filename, "w") do |file|
      file.write(new_contents.uniq.join("\n"))
    end
  end
end
