command :warnings do |c|
  c.syntax = 'liftoff warnings [options]'
  c.summary = 'Enable all warnings.'
  c.description = ''

  c.action do |args, options|
    XcodeprojHelper.new.enable_all_warnings
  end
end
