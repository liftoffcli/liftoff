module Liftoff
  class ObjectPicker
    def self.choose_item(title, objects)
      if objects.empty?
        STDERR.puts "Could not locate any #{title}s!"
        exit 1
      elsif objects.size == 1
        objects.first
      else
        choose("Which #{title} would you like to modify?") do |menu|
          menu.index = :number
          objects.map { |object| menu.choice(object) }
        end
      end
    end
  end
end
