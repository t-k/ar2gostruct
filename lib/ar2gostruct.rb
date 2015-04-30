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
  MODEL_DIR = ENV["model_dir"] || "app/models"

  def self.load
    path = ENV["require_path"] || "#{Dir.pwd}/config/environment"
    if File.exists?(path) || File.exists?("#{path}.rb")
      require path
      Rails.application.eager_load! if defined?(Rails)
    else
      raise "failed to load app"
    end
  end

  def self.convert!
    gostruct = Gostruct.new(MODEL_DIR)
    gostruct.convert!
  end

end

require "ar2gostruct/const"
require "ar2gostruct/converter"
require "ar2gostruct/gostruct"
require "ar2gostruct/builder/association"
require "ar2gostruct/builder/orm/gorm"
require "ar2gostruct/builder/orm/qbs"
require "ar2gostruct/builder/orm/validator"
require "ar2gostruct/builder/association"