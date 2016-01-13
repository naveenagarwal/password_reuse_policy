require_relative 'spec_helper'

describe PasswordReusePolicy::Configuration do

  before do
    PasswordReusePolicy::Configuration.default!
  end

  it 'should have default configuration' do
    PasswordReusePolicy::Configuration.password_attribute_name.must_equal :encrypted_password
    PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used.must_equal 3
    PasswordReusePolicy::Configuration.error_field_name.must_equal :password
  end

  it 'should abe able to override default configuration' do
    PasswordReusePolicy::Configuration.config do |c|
      c.password_attribute_name = :pass
      c.number_of_passwords_cannot_be_used = 2
      c.error_field_name = :error_pass
    end

    PasswordReusePolicy::Configuration.password_attribute_name.must_equal :pass
    PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used.must_equal 2
    PasswordReusePolicy::Configuration.error_field_name.must_equal :error_pass
  end
end
