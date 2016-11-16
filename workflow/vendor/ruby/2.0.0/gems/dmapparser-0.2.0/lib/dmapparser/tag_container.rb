module DMAPParser
  # The TagContainer class is a Tag which contains other Tags
  class TagContainer < Tag
    def initialize(type, value = [])
      super
    end

    def inspect(level = 0)
      "#{'  ' * level}#{type}:\n" + value.reduce('') do |a, e|
        a + e.inspect(level + 1).chomp + "\n"
      end
    end

    def get_value(key)
      return value[key] if key.is_a? Fixnum
      tag = get_tag(key)
      return unless tag
      tag.type.container? ? tag : tag.value
    end

    def get_tag(key)
      key = key.to_s
      value.find { |e| e.type.tag == key || e.type.name == key }
    end

    alias_method :[], :get_value

    def has?(key)
      !get_tag(key).nil?
    end

    def method_missing(method, *_arguments, &_block)
      if method =~ /(.*)\?$/
        has?(Regexp.last_match[1])
      elsif has?(method)
        get_value(method)
      else
        nil
      end
    end

    def respond_to?(method)
      method.to_s.match(/(.*)\??$/)
      has?(Regexp.last_match[1]) || super
    end

    def to_a
      value
    end

    private

    def convert_value(value)
      value.reduce('') { |a, e| a + e.to_dmap }
    end
  end
end
