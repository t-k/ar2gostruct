require "active_record"

class User < ActiveRecord::Base
  has_one :profile
  has_many :projects
end

class Profile < ActiveRecord::Base
  belongs_to :user
end

class Project < ActiveRecord::Base
  belongs_to :user
end

Dir::mkdir("db") unless File.exists?("db")

ActiveRecord::Base.establish_connection \
  :adapter => "sqlite3",
  :database => "db/test.db",
  :pool => 5,
  :timeout => 5000

ActiveRecord::Migrator.migrate("./spec/db/migrate")
