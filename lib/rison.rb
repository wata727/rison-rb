require "strscan"

require "rison/version"
require "rison/parser"
require "rison/object_parser"
require "rison/array_parser"

module Rison
  class ParserError < StandardError; end
  class InvalidMode < StandardError; end

  class << self
    def parse(source, options = {})
      mode = options[:mode] || :default

      parser_class = case mode.to_sym
                     when :default
                       Parser
                     when :object
                       ObjectParser
                     when :array
                       ArrayParser
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
      when Array
        object.map { |e| deep_symbolize_names(e) }
      else
        object
      end
    end
  end
end
