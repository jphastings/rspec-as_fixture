require 'yaml'

module RSpec
  module AsFixture
    @fixtures_dir = 'spec/fixtures'
    class << self
      attr_accessor :fixtures_dir

      def included(klass)
        raise if (@@loaded rescue false)
        @@loaded = true
        klass.around do |example|
          title = nil
          group = example.metadata[:example_group]
          loop do
            title = group[:description] if group[:as_fixture]
            break if group[:parent_example_group].nil?
            group = group[:parent_example_group]
          end

          described_class = group[:description]
          source = described_class.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
          load_fixture_file(source)

          if title     
            fixture_properties(source, title).each do |key, value|
              klass.let(key) { value }
            end
          end

          example.run
        end
      end
    end

    private

    def load_fixture_file(source)
      path = File.join(AsFixture.fixtures_dir, "#{source}.{yml,yaml}")

      @fixtures ||= {}
      @fixtures[source] ||= begin
        Dir.glob(path).map { |file|
          YAML.load(File.read(file))
        }.flatten
      end

      raise "No fixture for #{source} (at #{path})" if @fixtures[source].empty?
    end

    def fixture_properties(source, title)
      raise "No fixture for #{source} with title #{title}" unless @fixtures[source]
      @fixtures[source].find { |f| f['title'] == title }.select { |k, _| k != 'title' }
    end
  end
end
