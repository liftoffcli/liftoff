command :all do |c|
  c.syntax = 'liftoff all'
  c.summary = 'Run all possible commands. (Default)'
  c.action do |args, options|
    unless args.empty?
      say "I don't know what to do with that!"
      say 'Run liftoff help to see a list of available commands'
      exit
    end

    GitHelper.new.generate_files

    xcode_helper = XcodeprojHelper.new
    xcode_helper.set_indentation_level 4
    xcode_helper.treat_warnings_as_errors
    xcode_helper.add_todo_script_phase
    xcode_helper.enable_hosey_warnings
  end
end
