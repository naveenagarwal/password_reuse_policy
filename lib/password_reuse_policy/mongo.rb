module PasswordReusePolicy::Mongo
  module ClassMethods
    def register!
      raise NoMongoid::DocumentError, "Mongoid::Document is not defiend" unless defined? Mongoid::Document
      raise NoMongoid::DocumentError, "Mongoid::Document is not inlcuded in the class" unless self.include? Mongoid::Document

      field :last_used_passwords, type: Hash, default: {}
      before_save :set_last_used_passwords,  :if => :password_present?
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.register!
    receiver.send :include, PasswordReusePolicy::InstanceMethods
  end
end
