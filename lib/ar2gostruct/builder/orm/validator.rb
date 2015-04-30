# validator https://github.com/go-validator/validator
require "ar2gostruct/builder/orm/base"
module Ar2gostruct
  module Builder
    module ORM
      class Validator < Base

        def get_option(col)
          orm_option = []

          # not null Constraint
          orm_option << "nonzero" unless col.null

          validators = self.klass.validators_on col.name
          
          validators.each do |validator|
            orm_option.concat get_validation_rules(validator)
          end

          if orm_option.present?
            return "validate:\"#{orm_option.join(TAG_SEPARATOR)}\""
          else
            return nil
          end
        end

        def get_validation_rules(validator)
          rules = []
          case validator.class.to_s
          # when "ActiveModel::Validations::FormatValidator"
          #   if validator.options && validator.options[:with]
          #     rules << "regexp=#{validator.options[:with]}"
          #   end
          when "ActiveModel::Validations::LengthValidator"
            if validator.options
              rules << "min=#{validator.options[:minimum]}" if validator.options[:maximum]
              rules << "max=#{validator.options[:maximum]}" if validator.options[:maximum]
            end
          end
          return rules
        rescue => e
          []
        end

      end
    end
  end
end