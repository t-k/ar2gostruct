module Ar2gostruct
  class Gostruct
    def initialize(model_dir)
      @model_dir = model_dir
      get_models
    end
    attr_accessor :model_dir, :models

    def convert!
      self.models.each do |m|
        class_name = m.sub(/\.rb$/,'').camelize
        begin
          klass = class_name.split('::').inject(Object){ |klass,part| klass.const_get(part) }
          if klass < ActiveRecord::Base && !klass.abstract_class?
            convert_to_gostruct!(klass)
          end
        rescue Exception => e
          puts "// Unable to convert #{class_name}: #{e.message}"
        end
      end
    end

    private

      def get_models
        Dir.chdir(self.model_dir) do
          self.models = Dir["**/*.rb"]
        end
      end

      def convert_to_gostruct!(klass)
        converter = Converter.new klass, :plural => ENV["plural"], :orm => ENV["orm"]
        info = converter.convert!
        model_file_name = File.join(self.model_dir, klass.name.underscore + ".rb")
        puts "// #{model_file_name}"
        puts info
      end

  end
end