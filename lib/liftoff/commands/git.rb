command :git do |c|
  c.syntax = 'liftoff git [options]'
  c.summary = 'Add default .gitignore and .gitattributes files.'
  c.description = ''

  c.action do |args, options|
    GitHelper.new.generate_files
  end
end
