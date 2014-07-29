# QBS https://github.com/coocood/qbs
require "ar2gostruct/builder/orm/base"
module Ar2gostruct
  module Builder
    module ORM
      class QBS < Base

        def get_option(col)
          orm_option = []
          # primary key
          if col.name == @klass.primary_key
            orm_option << "pk"
          end
          # not null Constraint
          unless col.null
            orm_option << "notnull"
          end
          # default value
          if col.default
            orm_option << "default:'#{col.default}'"
          end
          # set timestamp
          if col.name == "created_at"
            orm_option << "created"
          elsif col.name == "updated_at"
            orm_option << "updated"
          end
          if orm_option.present?
            return "qbs:\"#{orm_option.join(TAG_SEPARATOR)}\""
          else
            return nil
          end
        end

      end
    end
  end
end