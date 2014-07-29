module Ar2gostruct
  module Builder
    class Association
      def initialize(klass, max_col_size, max_type_size)
        @klass = klass
        @max_col_size = max_col_size
        @max_type_size = max_type_size
      end
      attr_reader :klass, :max_col_size, :max_type_size

      def get_schema_info
        info = ""
        self.klass.reflect_on_all_associations.each do |assoc|
          tags = ["json:\"#{assoc.name.to_s}\""]
          case assoc.macro
          when :has_many
            col_name = assoc.name.to_s.camelize
            type_name = "[]#{assoc.name.to_s.singularize.camelize}"
          when :has_one, :belongs_to
            col_name = assoc.name.to_s.camelize
            type_name = col_name
          end
          if col_name && type_name
            info << sprintf("\t%-#{self.max_col_size}.#{self.max_col_size+2}s%-#{self.max_type_size}.#{self.max_type_size}s`%s`\n", col_name, type_name, tags.join(" "))
          end
        end
        info
      end

    end
  end
end