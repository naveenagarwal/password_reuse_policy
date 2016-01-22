require_relative 'spec_helper'

describe PasswordReusePolicy::Configuration do

  before do
    PasswordReusePolicy::Configuration.default!
  end

  it 'should have default configuration' do
    PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used.must_equal 3
    PasswordReusePolicy::Configuration.error_field_name.must_equal :password
    PasswordReusePolicy::Configuration.password_field_name.must_equal :password
    PasswordReusePolicy::Configuration.encryption.name.must_equal "Digest::MD5"
  end

  it 'should abe able to override default configuration' do
    PasswordReusePolicy::Configuration.config do |c|
      c.number_of_passwords_cannot_be_used = 2
      c.error_field_name = :error_pass
      c.password_field_name = :password
    end

    PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used.must_equal 2
    PasswordReusePolicy::Configuration.error_field_name.must_equal :error_pass
    PasswordReusePolicy::Configuration.password_field_name.must_equal :password
    PasswordReusePolicy::Configuration.encryption.name.must_equal "Digest::MD5"
  end
end
