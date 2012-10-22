command :releasewarnings do |c|
	c.syntax = 'liftoff releasewarnings [options]'
	c.summary = 'Treat all warnings as errors in release schemes.'
	c.description = ''

	c.action do |args, options|
		helper = XcodeprojHelper.new
		helper.treat_warnings_as_errors 
	end
end