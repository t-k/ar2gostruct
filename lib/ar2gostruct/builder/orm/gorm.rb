# GORM https://github.com/jinzhu/gorm
require "ar2gostruct/builder/orm/base"
module Ar2gostruct
  module Builder
    module ORM
      class GORM < Base

        TAG_SEPARATOR = ";"

        def get_option(col)
          orm_option = []
          # not null Constraint
          unless col.null
            orm_option << "not null"
          end
          # set size
          if col.type == :string
            # SQL type
            if col.sql_type && /\A\w+\(\d+\)/.match(col.sql_type)
              orm_option << "type:#{col.sql_type}"
            end
            orm_option << "size:#{col.limit}" if col.limit
          end

          if orm_option.present?
            return "sql:\"#{orm_option.join(TAG_SEPARATOR)}\""
          else
            return nil
          end
        end

      end
    end
  end
end