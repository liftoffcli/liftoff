command :warnings do |c|
  c.syntax = 'liftoff warnings [options]'
  c.summary = 'Enable all warnings.'
  c.description = ''

  c.action do |args, options|
    helper = XcodeprojHelper.new
    helper.enable_all_warnings
  end
end
