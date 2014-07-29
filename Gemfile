source "https://rubygems.org"

group :development do
  gem "yard"
end

group :development, :test do
  gem "simplecov"
  platform :ruby do
    gem "sqlite3"
  end
  platform :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
  end

  if RUBY_PLATFORM =~ /darwin/
    gem "ruby_gntp"
    gem "rb-fsevent"
  end
  if RUBY_PLATFORM =~ /linux/
    gem "libnotify"
    gem "rb-inotify"
  end
end
gemspec
