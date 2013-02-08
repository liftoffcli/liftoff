# Temp fix while waiting for an update to Xcodeproj
# https://github.com/CocoaPods/Xcodeproj/pull/50
module Xcodeproj
  class Project
    module Object
      class PBXNativeTarget
        def to_s
          self.name
        end
      end
    end
  end
end
