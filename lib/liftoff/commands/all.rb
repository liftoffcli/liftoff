command :all do |c|
	c.syntax = 'liftoff all [options]'
	c.summary = 'Run all possible commands.'
	c.description = ''
	c.example 'description', 'command example'
	c.option '--some-switch', 'Some switch that does something'
	c.action do |args, options|
		puts 'All'
	end
end