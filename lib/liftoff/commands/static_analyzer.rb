command :analyzer do |c|
  c.syntax = 'liftoff analyzer'
  c.summary = 'Turn on Static Analyzer for the project'
  c.description = ''

  c.action do
    XcodeprojHelper.new.enable_static_analyzer
  end
end
