require "spec_helper"

describe "Ar2gostruct::Builder::ORM::GORM" do

  describe "#get_option" do
    it "should output GORM format tags" do
      orm_converter = Ar2gostruct::Builder::ORM::GORM.new User
      # id
      result = orm_converter.get_option User.columns[0]
      expect(result).to eq("sql:\"not null\"")
      # email
      result = orm_converter.get_option User.columns[1]
      expect(result).to eq("sql:\"not null;type:varchar(255);size:255\"")
      # sign_in_count
      result = orm_converter.get_option User.columns[2]
      expect(result).to eq("sql:\"not null\"")
      # current_sign_in_at
      result = orm_converter.get_option User.columns[3]
      expect(result).to eq(nil)
      # last_sign_in_at
      result = orm_converter.get_option User.columns[4]
      expect(result).to eq(nil)
      # current_sign_in_ip
      result = orm_converter.get_option User.columns[5]
      expect(result).to eq("sql:\"type:varchar(40);size:40\"")
      # last_sign_in_ip
      result = orm_converter.get_option User.columns[6]
      expect(result).to eq("sql:\"type:varchar(40);size:40\"")
      # created_at
      result = orm_converter.get_option User.columns[7]
      expect(result).to eq(nil)
      # updated_at
      result = orm_converter.get_option User.columns[8]
      expect(result).to eq(nil)
    end
  end

end