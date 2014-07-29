module Ar2gostruct
  module Builder
    module ORM
      class Base
        TAG_SEPARATOR = ","

        def initialize(klass)
          @klass = klass
        end
        attr_reader :klass

      end
    end
  end
end