require 'yaml'

module RSpec
  module AsFixture
    @fixtures_dir = 'spec/fixtures'
    class << self
      attr_accessor :fixtures_dir

      def included(klass)
        klass.around do |example|
          fixture_title = nil
          group = example.metadata[:example_group]
          loop do
            fixture_title ||= group[:description] if group[:as_fixture]
            break if group[:parent_example_group].nil?
            group = group[:parent_example_group]
          end

          if fixture_title
            properties = load_fixture(klass: group[:description], title: fixture_title)

            properties.each do |key, value|
              klass.let(key) { value }
            end
          end

          example.run
        end
      end
    end

    private

    def load_fixture(klass:, title:)
      source = klass.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
      path = File.join(AsFixture.fixtures_dir, "#{source}.{yml,yaml}")

      @fixtures ||= {}
      @fixtures[source] ||= begin
        Dir.glob(path).map { |file|
          YAML.load(File.read(file))
        }.flatten
      end

      fixture = @fixtures[source].find { |f| f['title'] == title }
      raise "No fixture for #{klass} (at #{path}) with the title '#{title}'" if fixture.nil?
      fixture.select { |k, _| k != 'title' }
    end
  end
end
