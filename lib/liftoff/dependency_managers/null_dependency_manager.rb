module Liftoff
  class NullDependencyManager < DependencyManager
    def setup; end
    def install; end
  end
end
