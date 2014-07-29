require "spec_helper"

describe "Ar2gostruct::Builder::Association" do

  def get_max_col_size(klass)
    col_name_max_size = klass.column_names.collect{|name| name.size}.max || 0
    assoc_max_size = klass.reflect_on_all_associations.collect{|assoc| assoc.name.to_s.size}.max || 0
    type_max_size = Ar2gostruct::CONST::TYPE_MAP.collect{|key, value| key.size}.max || 0
    [col_name_max_size, assoc_max_size, type_max_size].max
  end

  def get_max_type_size(klass)
    assoc_max_size = klass.reflect_on_all_associations.collect{|assoc| assoc.name.to_s.size + 2}.max || 0
    type_max_size = Ar2gostruct::CONST::TYPE_MAP.collect{|key, value| key.size}.max || 0
    [assoc_max_size, type_max_size].max
  end

  describe "#get_schema_info" do
    it "should output associations" do
      klass = User
      builder = Ar2gostruct::Builder::Association.new(klass, get_max_col_size(klass), get_max_type_size(klass))
      result = builder.get_schema_info
      expect(result).to match(/Profile/)
      expect(result).to match(/json:\"profile\"`/)
      expect(result).to match(/Projects/)
      expect(result).to match(/\[\]Project/)
      expect(result).to match(/json:\"projects\"`/)

      klass = Profile
      builder = Ar2gostruct::Builder::Association.new(klass, get_max_col_size(klass), get_max_type_size(klass))
      result = builder.get_schema_info
      expect(result).to match(/User/)
      expect(result).to match(/json:\"user\"`/)

      klass = Project
      builder = Ar2gostruct::Builder::Association.new(klass, get_max_col_size(klass), get_max_type_size(klass))
      result = builder.get_schema_info
      expect(result).to match(/User/)
      expect(result).to match(/json:\"user\"`/)
    end
  end

end