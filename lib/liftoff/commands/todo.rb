command :todo do |c|
  c.syntax = 'liftoff todo [options]'
  c.summary = 'Add a build script to treat TODO and FIXME as warnings.'
  c.description = ''

  c.action do |args, options|
    helper = XcodeprojHelper.new
    helper.add_todo_script_phase
  end
end
