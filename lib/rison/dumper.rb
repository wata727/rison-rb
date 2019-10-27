module Rison
  class Dumper
    class << self
      def dump(object)
        case object
        when TrueClass
          "!t"
        when FalseClass
          "!f"
        when NilClass
          "!n"
        when Numeric
          object.to_s.gsub('+', '')
        when Hash
          "(#{object.map { |k, v| dump(k) + ':' + dump(v) }.join(',')})"
        when ::Array
          "!(#{object.map { |e| dump(e) }.join(',')})"
        else
          escape(object.to_s)
        end
      end

      private

      def escape(str)
        id?(str) ? str : "'#{str.gsub('!', '!!').gsub("'", "!'")}'"
      end

      def id?(str)
        str.match?(/^[^\-0-9 '!:\(\),\*@¥\$][^ '!:\(\),\*@¥\$]*$/)
      end
    end
  end
end
