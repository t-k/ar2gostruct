module Ar2gostruct
  module CONST
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
  end
end