unless File.exists?("./Rakefile") || File.exists?("./Gemfile")
  abort "Please run ar2gostruct from the root of the project."
end

require "rubygems"
begin
  require "rubygems"
  require "bundler/setup"
rescue Exception => e
end

require "ar2gostruct/version"

require "active_support/inflector"
require "active_record"

require "ar2gostruct/railtie" if defined?(Rails)

module Ar2gostruct
  MODEL_DIR   = ENV["model_dir"] || "app/models"

  TYPE_MAP = {
    "string"     => "string",
    "text"       => "string",
    "boolean"    => "bool",
    "integer(1)" => "int8",
    "integer(2)" => "int16",
    "integer(3)" => "int32",
    "integer(4)" => "int32",
    "integer(8)" => "int64",
    "float"      => "float64",
    "datetime"   => "time.Time",
    "date"       => "time.Time"
  }

  def self.load
    path = ENV["require_path"] || "#{Dir.pwd}/config/environment"
    if File.exists?(path) || File.exists?("#{path}.rb")
      require path
      Rails.application.eager_load! if defined?(Rails)
    else
      raise "failed to load app"
    end
  end

  def self.get_schema_info(klass)
    info = "// Table name: #{klass.table_name}\n"
    if ENV["plural"]
      struct_name = klass.table_name.camelize
    else
      struct_name = klass.to_s.tr_s('::', '')
    end
    info << "type #{struct_name} struct {\n"

    max_size = klass.column_names.collect{|name| name.size}.max + 1
    klass.columns.each do |col|
      tags = []

      # add json tag
      tags << "json:\"#{col.name}\""

      case ENV["orm"]
      when "qbs"
        orm_option = []
        # primary key
        if col.name == klass.primary_key
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
          tags << "qbs:\"#{orm_option.join(",")}\""
        end
      end

      col_type = col.type.to_s
      case col_type
      when "integer"
        type = TYPE_MAP["integer(#{col.limit})"] || "int32"
        type = "u#{type}" if col.sql_type.match("unsigned").present?
      else
        type = TYPE_MAP[col_type] || "string"
      end

      info << sprintf("\t%-#{max_size}.#{max_size}s%-15.15s`%s`\n", col.name.camelize, type, tags.join(" "))

    end

    info << "}\n\n"
  end

  def self.convert_to_gostruct(klass)
    info = get_schema_info(klass)

    model_file_name = File.join(MODEL_DIR, klass.name.underscore + ".rb")

    puts "// #{model_file_name}"
    puts info
  end

  def self.get_model_names
    models = []
    Dir.chdir(MODEL_DIR) do
      models = Dir["**/*.rb"]
    end
    models
  end

  def self.convert!
    self.get_model_names.each do |m|
      class_name = m.sub(/\.rb$/,'').camelize
      begin
        klass = class_name.split('::').inject(Object){ |klass,part| klass.const_get(part) }
        if klass < ActiveRecord::Base && !klass.abstract_class?
          self.convert_to_gostruct(klass)
        end
      rescue Exception => e
        puts "// Unable to convert #{class_name}: #{e.message}"
      end

    end
  end
end
