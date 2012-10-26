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
    File.open(".gitignore", "a") do |file|
      file.write(GITIGNORE_CONTENTS)
    end
  end

  def generate_gitattributes
    File.open(".gitattributes", "a") do |file|
      file.write(GITATTRIBUTES_CONTENTS)
    end
  end
end
