INDENT_SPACES = 4

command :indentation do |c|
  c.syntax = 'liftoff indentation [width(optional)]'
  c.summary = 'Set project indentation level'
  c.description = 'Set the number of spaces used to indent code. Defaults to 4'

  c.action do |args, options|
    indentation_level = args.first || INDENT_SPACES
    XcodeprojHelper.new.set_indentation_level indentation_level
  end
end
