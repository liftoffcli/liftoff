class ProjectConfiguration

  ATTRIBUTES = %i(git error todo staticanalyzer indentation warnings directories)

  attr_accessor *ATTRIBUTES

  def initialize(hash)
    hash.each_pair do |attr, val|
      if respond_to?("#{attr}=")
        send("#{attr}=", val)
      else
        STDERR.puts "Unknown key #{attr} found in liftoffrc!"
        exit 1
      end
    end
  end
end
