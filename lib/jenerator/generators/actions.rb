module Jenerator
  module Actions
    def self.included(base)
      base.extend(ClassMethods)
    end

    def destination_root(*paths)
      File.expand_path(File.join(@destination_stack.last, paths))
    end

    module ClassMethods
      def require_arguments!
        @require_arguments = true
      end

      def require_arguments?
        @require_arguments
      end
    end
  end
end