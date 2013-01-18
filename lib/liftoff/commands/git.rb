command :git do |c|
  c.syntax = 'liftoff git'
  c.summary = 'Add default .gitignore and .gitattributes files.'
  c.description = ''

  c.action do
    GitHelper.new.generate_files
  end
end
