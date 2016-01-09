require_relative 'spec_helper'

describe PasswordReusePolicy::Configuration do

  before do
    PasswordReusePolicy::Configuration.default!
  end

  it 'should have default configuration' do
    PasswordReusePolicy::Configuration.password_attribute_name.must_equal :password
    PasswordReusePolicy::Configuration.unuses_last_passwords.must_equal 3
  end

  it 'should abe able to override default configuration' do
    PasswordReusePolicy::Configuration.config do |c|
      c.password_attribute_name = :pass
      c.unuses_last_passwords = 2
    end

    PasswordReusePolicy::Configuration.password_attribute_name.must_equal :pass
    PasswordReusePolicy::Configuration.unuses_last_passwords.must_equal 2
  end
end
