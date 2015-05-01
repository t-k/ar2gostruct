# Ar2gostruct
[![Gem Version](https://badge.fury.io/rb/ar2gostruct.png)](https://rubygems.org/gems/ar2gostruct)
[![Build Status](https://travis-ci.org/t-k/ar2gostruct.png)](https://travis-ci.org/t-k/ar2gostruct)

Automatically generate Golang Struct from your activerecord models.

Installation
---

Install GMO as a gem:
```bash
gem install ar2gostruct
```

or add to your Gemfile:
```ruby
# Gemfile
gem "ar2gostruct"
```
and run bundle install to install the dependency.

Usage
---

On your rails directory.
```bash
bundle exec rake ar2gostruct association=true
# association option enables Active Record Associations (Needs ar2gostruct v0.2.0 or greater).
# or
bundle exec ar2gostruct --a
# If you prefer plural struct name, "--plural" option is available.
```
this will returns
```bash
// app/models/user.rb
// Table name: users
type User struct {
  Id                     int32          `json:"id"`
  Email                  string         `json:"email"`
  EncryptedPassword      string         `json:"encrypted_password"`
  ResetPasswordToken     string         `json:"reset_password_token"`
  ResetPasswordSentAt    time.Time      `json:"reset_password_sent_at"`
  RememberCreatedAt      time.Time      `json:"remember_created_at"`
  SignInCount            int32          `json:"sign_in_count"`
  CurrentSignInAt        time.Time      `json:"current_sign_in_at"`
  LastSignInAt           time.Time      `json:"last_sign_in_at"`
  CurrentSignInIp        string         `json:"current_sign_in_ip"`
  LastSignInIp           string         `json:"last_sign_in_ip"`
  ConfirmationToken      string         `json:"confirmation_token"`
  ConfirmedAt            time.Time      `json:"confirmed_at"`
  ConfirmationSentAt     time.Time      `json:"confirmation_sent_at"`
  UnconfirmedEmail       string         `json:"unconfirmed_email"`
  CreatedAt              time.Time      `json:"created_at"`
  UpdatedAt              time.Time      `json:"updated_at"`
  Profile                Profile        `json:"profile"`
  Projects               []Project      `json:"projects"`
}
```

If you're using [qbs](https://github.com/coocood/qbs#), [gorm](https://github.com/jinzhu/gorm) or [validator](https://github.com/go-validator/validator), Additional options are available.

```bash
bundle exec rake ar2gostruct orm=qbs
# or
ar2gostruct -o qbs
# Using comma separated value, you can specify multiple ORMs(e.g. "ar2gostruct --o validator,qbs").

// app/models/user.rb
// Table name: users
type User struct {
  Id                     int32          `json:"id" qbs:"pk,notnull"`
  Email                  string         `json:"email" qbs:"notnull,default:''"`
  EncryptedPassword      string         `json:"encrypted_password" qbs:"notnull,default:''"`
  ResetPasswordToken     string         `json:"reset_password_token"`
  ResetPasswordSentAt    time.Time      `json:"reset_password_sent_at"`
  RememberCreatedAt      time.Time      `json:"remember_created_at"`
  SignInCount            int32          `json:"sign_in_count" qbs:"default:'0'"`
  CurrentSignInAt        time.Time      `json:"current_sign_in_at"`
  LastSignInAt           time.Time      `json:"last_sign_in_at"`
  CurrentSignInIp        string         `json:"current_sign_in_ip"`
  LastSignInIp           string         `json:"last_sign_in_ip"`
  ConfirmationToken      string         `json:"confirmation_token"`
  ConfirmedAt            time.Time      `json:"confirmed_at"`
  ConfirmationSentAt     time.Time      `json:"confirmation_sent_at"`
  UnconfirmedEmail       string         `json:"unconfirmed_email"`
  CreatedAt              time.Time      `json:"created_at" qbs:"created"`
  UpdatedAt              time.Time      `json:"updated_at" qbs:"updated"`
}


```

Contributing
---

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
