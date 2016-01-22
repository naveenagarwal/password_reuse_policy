require_relative 'spec_helper'

describe PasswordReusePolicy do
  it 'has a version number' do
    PasswordReusePolicy::VERSION.wont_equal nil
  end
end
