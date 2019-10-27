module Rison
  module Array
    class Dumper < ::Rison::Dumper
      class << self
        def dump_array(object)
          case object
          when []
            %('')
          when ::Array
            object.map { |e| dump(e) }.join(',')
          else
            raise DumperError.new("A-Rison only accepts Array as the top level, but #{object.inspect} received.")
          end
        end
      end
    end
  end
end
