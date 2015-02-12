module Xcodeproj
  class Project
    module Object
      class PBXNativeTarget
        def []=(key, value)
          self.build_configurations.each do |configuration|
            configuration.build_settings[key] = value
          end
        end

        def merge!(hash)
          hash.each do |key, value|
            self[key] = value
          end
        end
      end
    end
  end
end
