require 'active_support/core_ext'
require 'active_support/ordered_hash'
require 'ffaker'

module Jenerator
  module Generators
    # Path To Source Folder
    DEV_PATH = File.expand_path("../../", File.dirname(__FILE__))

    class << self
      def load_paths
        @_files ||= []
      end

      def mappings
        @_mappings ||= ActiveSupport::OrderedHash.new
      end

      def add_generator(name, klass)
        mappings[name] = klass
      end

      def load_components!
        load_paths.flatten.each { |file| require file  }
      end
    end
  end
end

Jenerator::Generators.load_paths << Dir[File.dirname(__FILE__) + '/jenerator/generators/{actions,component}.rb']