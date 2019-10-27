module Rison
  module Object
    class Dumper < ::Rison::Dumper
      class << self
        def dump_object(object)
          case object
          when {}
            %('')
          when Hash
            object.map { |k, v| dump(k) + ':' + dump(v) }.join(',')
          else
            raise DumperError.new("O-Rison only accepts Hash as the top level, but #{object.inspect} received.")
          end
        end
      end
    end
  end
end
