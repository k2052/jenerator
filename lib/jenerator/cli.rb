require 'thor/group'

module Jenerator
  class CLI < Thor::Group
    include Thor::Actions

    class_option :root, :desc => "The root destination", :aliases => '-r', :default => ".", :type => :string
    class_option :help, :type => :boolean, :desc => "Show help usage"

    # Loads the components available for all generators.
    # @private
    def setup
      Jenerator::Generators.load_components!

      generator_kind  = ARGV.delete_at(0).to_s.downcase.to_sym if ARGV[0].present?
      generator_class = Jenerator::Generators.mappings[generator_kind]

      if generator_class
        args = ARGV.empty? && generator_class.require_arguments? ? ["-h"] : ARGV
        generator_class.start(args)
      else
        puts "Please specify generator to use (#{Jenerator::Generators.mappings.keys.join(", ")})"
      end
    end
  end 
end