command :warnings do |c|
  c.syntax = 'liftoff warnings'
  c.summary = 'Enable all warnings.'
  c.description = ''

  c.action do
    XcodeprojHelper.new.enable_all_warnings
  end
end
