module Ar2gostruct
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'ar2gostruct/railties/ar2gostruct.rake'
    end
  end
end