module PasswordReusePolicy::Mongo
  module ClassMethods
    def register!
      raise NoMongoid::DocumentError, "Mongoid::Document is not defiend" unless defined? Mongoid::Document
      raise NoMongoid::DocumentError, "Mongoid::Document is not inlcuded in the class" unless self.include? Mongoid::Document

      field :last_used_passwords, type: Hash, default: {}
      before_save :set_last_used_passwords,  :if => :password_has_changed?
    end
  end

  module InstanceMethods
    private

    def password_has_changed?
      changes[PasswordReusePolicy::Configuration.password_attribute_name.to_s].present?
    end

    def set_last_used_passwords
      n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
      return false if n < 1

      new_password = public_send(PasswordReusePolicy::Configuration.password_attribute_name)

      if self.last_used_passwords.values.include? new_password
        self.errors.add(PasswordReusePolicy::Configuration.error_field_name, "Password can't be same as last #{n} passwords")
        return false
      else
        set_new_password_hash_with new_password, n
      end
    end

    def set_new_password_hash_with new_password, n
      used_passwords = (self.last_used_passwords || {}).to_a
      used_passwords.unshift ["1", new_password]
      used_passwords[1..-1].each { |used_password| used_password[0] = used_password[0].to_i + 1 }
      used_passwords = used_passwords.take n
      self.last_used_passwords = used_passwords.to_h
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.register!
    receiver.send :include, InstanceMethods
  end
end
