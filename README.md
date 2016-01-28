# PasswordReusePolicy

It is a module/gem to set the password resue policy for the registered users. Means you can set a limit, only after which a user will be able to resue the same password. For example if a user's password is "12345" and limit is 3, then he can only use password "12345" again after setting three different password.

It should work with any authentication library which supports either active record or mongoid ORM. In case you have any difficulty in using this module in your applicaition do write me at [naveenagarwal287@gmail.com](mailto:naveenagarwal287@gmail.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'password_reuse_policy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install password_reuse_policy

## Usage

I am setting the example here for rails app, you can use it in any ruby app.

Configuration:

create a file named `password_reuse_policy.rb`

To add default configuration:

```ruby
PasswordReusePolicy::Configuration.default!
``` 

To override default configuration:

```ruby
PasswordReusePolicy::Configuration.config do |c|
  c.number_of_passwords_cannot_be_used = 3 #default, number of last used password which can not be used
  c.error_field_name = :password #default, error field name in which error will be set
  c.password_field_name = :password #default, field name from which password should be picked
endc
``` 

Link to sample applciation, devise is used for authentication, it uses password field name by default in the model.

To check the usage with active record visit
[https://github.com/naveenagarwal/password_reuse_policy_testapp](https://github.com/naveenagarwal/password_reuse_policy_testapp)

To check the usage with mongoid visit
[https://github.com/naveenagarwal/password_reuse_policy_testapp/tree/mogoid_module_test](https://github.com/naveenagarwal/password_reuse_policy_testapp/tree/mogoid_module_test)




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/password_reuse_policy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

