require_relative 'spec_helper'

describe PasswordReusePolicy::Mongo do

  before do
    PasswordReusePolicy::Configuration.default!
  end

  it "should throw error if Mongoid::Document is not defined" do
    begin
      class User
        include PasswordReusePolicy::Mongo
      end
    rescue NoMongoid::DocumentError => e
      e.message.must_equal "Mongoid::Document is not defiend"
    end
  end

  it 'should raise an error when model class does not have Mongoid::Document' do
    begin
      class User
        include PasswordReusePolicy::Mongo
      end
    rescue NoMongoid::DocumentError => e
      e.message.must_equal "Mongoid::Document is not inlcuded in the class"
    end
  end

  it "should also throw error if PasswordReusePolicy::Mongo is inlcuded before Mongoid::Document" do
    begin
      class User
        include PasswordReusePolicy::Mongo
        include Mongoid::Document
      end
    rescue NoMongoid::DocumentError => e
      e.message.must_equal "Mongoid::Document is not inlcuded in the class"
    end
  end

  it 'should not throw error when class inlcudes the Mongoid::Document' do
    begin
      class User
        include Mongoid::Document
        include PasswordReusePolicy::Mongo
      end
    rescue NoMongoid::DocumentError => e
      e.message.must_equal "It show never reach here"
    end
  end

  describe "Persisted model specs" do
    before do
      PasswordReusePolicy::Configuration.default!
    end
    class User
      include Mongoid::Document
      include PasswordReusePolicy::Mongo

      field :password, type: String

    end

    it "should define a field named last_used_passwords in the model when PasswordReusePolicy::Mongo is included" do
      User.new.respond_to?(:last_used_passwords).must_equal true
      User.new.last_used_passwords.must_equal {}
    end

    let(:user) { User.new }

    it "should save the last password set in the last_used_passwords field" do
      user.password = "pass1"
      user.save
      user.errors.messages.must_equal {}
      n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
      (0..n).to_a.any? { |i| user.last_used_passwords[i.to_s] == user.password }
    end

    it "should not let the same password again to be saved before the number_of_passwords_cannot_be_used limit reached" do

    end

    it "should allow to save the different password" do

    end

    it "should allow to reuse the password after the number_of_passwords_cannot_be_used limit reached" do

    end

  end

end
