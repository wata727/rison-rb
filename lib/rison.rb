require "strscan"

require "rison/version"
require "rison/dumper"
require "rison/parser"
require "rison/object/dumper"
require "rison/object/parser"
require "rison/array/dumper"
require "rison/array/parser"

module Rison
  class DumperError < StandardError; end
  class ParserError < StandardError; end
  class InvalidMode < StandardError; end

  class << self
    def dump(object, options = {})
      mode = options[:mode] || :default

      case mode.to_sym
      when :default
        ::Rison::Dumper.dump(object)
      when :object
        ::Rison::Object::Dumper.dump_object(object)
      when :array
        ::Rison::Array::Dumper.dump_array(object)
      else
        raise InvalidMode.new("Invalid mode: #{mode}")
      end
    end

    def parse(source, options = {})
      mode = options[:mode] || :default

      parser_class = case mode.to_sym
                     when :default
                       ::Rison::Parser
                     when :object
                       ::Rison::Object::Parser
                     when :array
                       ::Rison::Array::Parser
                     else
                       raise InvalidMode.new("Invalid mode: #{mode}")
                     end

      object = parser_class.parse(source)
      return object unless options[:symbolize_names]
      deep_symbolize_names(object)
    end
  
    private

    def deep_symbolize_names(object)
      case object
      when Hash
        object.each_with_object({}) do |(k, v), ret|
          ret[k.to_sym] = deep_symbolize_names(v)
        end
      when ::Array
        object.map { |e| deep_symbolize_names(e) }
      else
        object
      end
    end
  end
end
