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

# Cocoapods
Pods
Podfile.lock

# AppCode specific files
.idea/
*.iml
GITIGNORE

GITATTRIBUTES_CONTENTS = '*.pbxproj binary merge=union'

class GitHelper
  def initialize
    if Dir['*.xcodeproj'].empty?
      puts 'Could not find an Xcode project file. You need to run me from a valid project directory.'
      exit
    end
  end

  def generate_files
    generate_gitignore
    generate_gitattributes
  end

  private

  def generate_gitignore
    puts 'Writing .gitignore'
    write_unique_contents_to_file(GITIGNORE_CONTENTS, '.gitignore')
  end

  def generate_gitattributes
    puts 'Writing .gitattributes'
    write_unique_contents_to_file(GITATTRIBUTES_CONTENTS, '.gitattributes')
  end

  def write_unique_contents_to_file(contents, filename)
    if File.exists? filename
      current_file_contents = File.read(filename).split("\n")
    else
      current_file_contents = []
    end

    new_contents = current_file_contents + contents.split("\n")

    File.open(filename, 'w') do |file|
      file.write(new_contents.uniq.join("\n"))
    end
  end
end
