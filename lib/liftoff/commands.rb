$:.push File.expand_path('../', __FILE__)

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

command :git do |c|
	c.syntax = 'liftoff git [options]'
	c.summary = 'Add default .gitignore and .gitattributes files.'
	c.description = ''
	c.example 'description', 'command example'
	c.option '--some-switch', 'Some switch that does something'
	c.action do |args, options|
		puts 'Does git stuff'
	end
end

command :releasewarnings do |c|
	c.syntax = 'liftoff releasewarnings [options]'
	c.summary = 'Treat all warnings as errors in release schemes.'
	c.description = ''
	c.example 'description', 'command example'
	c.option '--some-switch', 'Some switch that does something'
	c.action do |args, options|
		puts 'Treats warnings as errors in release builds'
	end
end

command :todo do |c|
	c.syntax = 'liftoff todo [options]'
	c.summary = 'Add a build script to treat TODO and FIXME as warnings.'
	c.description = ''
	c.example 'description', 'command example'
	c.option '--some-switch', 'Some switch that does something'
	c.action do |args, options|
		puts 'Adds todo shell script'
	end
end

command :warnings do |c|
	c.syntax = 'liftoff warnings [options]'
	c.summary = 'Enable all warnings.'
	c.description = ''
	c.example 'description', 'command example'
	c.option '--some-switch', 'Some switch that does something'
	c.action do |args, options|
		puts 'Enables all warnings'
	end
end