require 'dmapparser/tag_definitions'
module DMAPParser
  # This class provides a DSL to create DMAP responses
  class Builder
    attr_reader :result

    def initialize
      @dmap_stack = []
    end

    def self.method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    def method_missing(method, *args, &block)
      tag = TagDefinition[method]
      return super if tag.nil?

      if block_given? || tag.container?
        fail "Tag #{tag} is not a container type" unless tag.container?
        build_container(tag, &block)
      else
        build_tag(tag, args)
      end
    end

    private

    def build_tag(tag, args)
      if @dmap_stack.length > 0
        args = args.size > 1 ? args : args.first
        @dmap_stack.last.value << Tag.new(tag, args)
      else
        fail 'Cannot build DMAP without a valid container'
      end
    end

    def build_container(tag, &block)
      @dmap_stack << TagContainer.new(tag)
      instance_exec(&block)
      if @dmap_stack.length > 1
        cur_tag = @dmap_stack.pop
        @dmap_stack.last.value << cur_tag
      else
        @result = @dmap_stack.pop
      end
    end
  end
end
