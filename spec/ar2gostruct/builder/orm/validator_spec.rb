require "spec_helper"

describe "Ar2gostruct::Builder::ORM::Validator" do

  describe "#get_option" do
    it "should output Validator format tags" do
      orm_converter = Ar2gostruct::Builder::ORM::Validator.new User
      # id
      result = orm_converter.get_option User.columns[0]
      expect(result).to eq("validate:\"nonzero\"")
      # email
      result = orm_converter.get_option User.columns[1]
      expect(result).to eq("validate:\"nonzero,min=1,max=120\"")
      # sign_in_count
      result = orm_converter.get_option User.columns[2]
      expect(result).to eq("validate:\"nonzero\"")
      # current_sign_in_at
      result = orm_converter.get_option User.columns[3]
      expect(result).to eq(nil)
      # last_sign_in_at
      result = orm_converter.get_option User.columns[4]
      expect(result).to eq(nil)
      # current_sign_in_ip
      result = orm_converter.get_option User.columns[5]
      expect(result).to eq(nil)
      # last_sign_in_ip
      result = orm_converter.get_option User.columns[6]
      expect(result).to eq(nil)
      # created_at
      result = orm_converter.get_option User.columns[7]
      expect(result).to eq(nil)
      # updated_at
      result = orm_converter.get_option User.columns[8]
      expect(result).to eq(nil)
    end
  end

end