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
      e.message.must_equal "It should never reach here"
    end
  end

  describe "Persisted model specs" do
    require 'mongoid'
    require 'database_cleaner'

    DatabaseCleaner.strategy = :truncation
    Mongo::Logger.logger.level = ::Logger::ERROR

    Mongoid.load!("#{File.dirname(__FILE__)}/config/mongoid.yml")

    before do
      PasswordReusePolicy::Configuration.default!
      DatabaseCleaner.start
      @encryption = PasswordReusePolicy::Configuration.encryption
    end

    after do
      DatabaseCleaner.clean
    end

    class User
      include Mongoid::Document
      include PasswordReusePolicy::Mongo

      attr_accessor :password

      field :encrypted_password, type: String
    end

    it "should define a field named last_used_passwords in the model when PasswordReusePolicy::Mongo is included" do
      User.new.respond_to?(:last_used_passwords).must_equal true
      value = {}
      User.new.last_used_passwords.must_equal value
    end

    let(:user) { User.new }

    it "should save the last password set in the last_used_passwords field" do
      user.encrypted_password = "pass1"
      user.password = "pass1"
      user.save
      user.errors.messages.must_be_empty
      n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
      password_digest = @encryption.hexdigest user.password
      (0..n).to_a.any?{ |i| user.last_used_passwords[i.to_s] == password_digest }.must_equal true
    end

    it "should not let the same password again to be saved before the number_of_passwords_cannot_be_used limit reached" do
      user.encrypted_password = "pass1"
      user.password = "pass1"
      user.save
      user.errors.messages.must_be_empty
      n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
      password_digest = @encryption.hexdigest user.password
      (0..n).to_a.any?{ |i| user.last_used_passwords[i.to_s] == password_digest }.must_equal true
      user.encrypted_password = "pass2"
      user.password = "pass2"
      user.save
      user.errors.messages.must_be_empty
      user.encrypted_password = "pass1"
      user.password = "pass1"
      user.save
      user.errors.messages.wont_be_empty
      user.errors[PasswordReusePolicy::Configuration.error_field_name].must_include "Password can't be same as last #{n} passwords"
    end

    it "should allow to save the different password" do
      [1,2].each do |i|
        user.encrypted_password = "pass#{i}"
        user.password = "pass#{i}"
        user.save
        user.errors.messages.must_be_empty
        n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
        password_digest = @encryption.hexdigest user.password
        (0..n).to_a.any?{ |i| user.last_used_passwords[i.to_s] == password_digest }.must_equal true
      end
    end

    it "should allow to reuse the password after the number_of_passwords_cannot_be_used limit reached" do
      2.times do
        [1,2,3,4].each do |i|
          user.encrypted_password = "pass#{i}"
          user.password = "pass#{i}"
          user.save
          user.errors.messages.must_be_empty
          password_digest = @encryption.hexdigest user.password
          n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
          (0..n).to_a.any?{ |i| user.last_used_passwords[i.to_s] == password_digest }.must_equal true
        end
      end
    end

  end

end
