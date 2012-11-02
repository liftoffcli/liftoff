command :all do |c|
  c.syntax = 'liftoff all'
  c.summary = 'Run all possible commands. (Default)'
  c.action do |args, options|
    git_helper = GitHelper.new
    git_helper.generate_files

    xcode_helper = XcodeprojHelper.new
    xcode_helper.set_indentation_level 4
    xcode_helper.treat_warnings_as_errors
    xcode_helper.add_todo_script_phase
    xcode_helper.enable_all_warnings
  end
end
