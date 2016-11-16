module DMAPParser
  # The Tag class
  class Tag < Struct.new(:type, :value)
    def initialize(type, value)
      unless type.is_a? TagDefinition
        type = TagDefinition[type] ||
               TagDefinition.new(type, :unknown, "unknown (#{length})")
      end
      super
    end

    def to_s
      "#<#{self.class.name} #{type}>"
    end

    def inspect(level = 0)
      "#{'  ' * level}#{type}: #{value}"
    end

    def to_dmap
      value = convert_value(self.value)
      length = [value.length].pack('N')
      (type.tag.to_s + length + value).force_encoding(Encoding::BINARY)
    end

    private

    def convert_value(value)
      Converter.encode(type.type, value)
    end
  end
end
