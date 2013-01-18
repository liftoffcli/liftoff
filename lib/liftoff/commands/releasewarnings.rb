command :releasewarnings do |c|
  c.syntax = 'liftoff releasewarnings'
  c.summary = 'Treat all warnings as errors in release schemes.'
  c.description = ''

  c.action do
    XcodeprojHelper.new.treat_warnings_as_errors
  end
end
