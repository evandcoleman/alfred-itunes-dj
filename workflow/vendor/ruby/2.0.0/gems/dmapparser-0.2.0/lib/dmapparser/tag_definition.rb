require 'dmapparser/tag'
require 'dmapparser/tag_container'

module DMAPParser
  # The TagDefinition class describes the tags
  class TagDefinition < Struct.new(:tag, :type, :name)
    DEFINITIONS = Hash.new(nil)

    def to_s
      "#{tag} (#{name}: #{type})"
    end

    alias_method :inspect, :to_s

    def container?
      type == :container
    end

    class << self
      def find(key)
        DEFINITIONS[key.to_s]
      end

      def tag(*args, &block)
        definition = new(*args, &block).freeze
        DEFINITIONS[definition.tag.to_s] = definition
      end

      alias_method :[], :find
    end
  end
end
