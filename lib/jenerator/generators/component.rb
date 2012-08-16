module Jenerator
  module Generators
    class Component < Thor::Group
      include Thor::Actions
      include Jenerator::Actions

      Jenerator::Generators.add_generator(:component, self)

      def self.source_root; File.expand_path(File.dirname(__FILE__)); end
      def self.banner; "jenerator component [name]"; end

      desc "Description:\n\n\tjenerator component generates a new Joomla! Component"

      argument :name,           :desc => "The name of the component"
      
      class_option :joomla_version, :desc => 'Joomla version',            :default => '2.5'
      class_option :element,        :desc => "The name of the component", :default => "com_NAME"
      class_option :author,         :desc => "The author",                :default => Faker::Name.name
      class_option :copyright,      :desc => "The copyright",             :default => "Copyright Author"
      class_option :licenser,       :desc => "The license",               :default => "GPL V3"
      class_option :author_emai,    :desc => "The author's email",        :default => Faker::Internet.email
      class_option :author_url,     :desc => "The author's url",          :default => "http://#{Faker::Internet.domain_name}"
      class_option :version,        :desc => "The version",               :default => "#{rand(100)}.#{rand(100)}.#{rand(100)}"
      class_option :description,    :desc => "The description",           :default => Faker::Lorem.paragraphs(1).join("\n")

      require_arguments!

      def create_component
        new_options = options.dup
        options = new_options

        options[:element]   = "com_#{self.name.downcase}"              if options[:element] == 'com_NAME'
        options[:copyright] = "Copyright #{options[:author]}" if options[:copyright] == "Copyright Author"


        self.destination_root = File.join(self.destination_root, options[:element])
        empty_directory "code/administrator/components/#{options[:element]}"
        empty_directory "code/site/components/#{options[:element]}"
        empty_directory "packages"
        empty_directory "tasks"

        template "templates/joomla#{options[:joomla_version]}/component/manifest.xml.tt", destination_root("code", "manifest.xml"), options
        template "templates/joomla#{options[:joomla_version]}/component/admin.php.tt", 
          destination_root("code/administrator/components/#{options[:element]}", "#{self.name.downcase}.php"), options
        template "templates/joomla#{options[:joomla_version]}/component/site.php.tt", 
          destination_root("code/site/components/#{options[:element]}", "#{self.name.downcase}.php"), options
      end
    end
  end
end