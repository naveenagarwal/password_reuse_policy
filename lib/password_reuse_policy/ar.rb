module PasswordReusePolicy::AR
  module ClassMethods
		def register!
      raise PasswordReusePolicy::ActiveRecodNotFoundError, "Could not find actve record" unless defined? ActiveRecord
			raise PasswordReusePolicy::ActiveRecodNotInherited, "Please inherit from active record class" unless ancestors.include? ActiveRecord::Base

			serialize :last_used_passwords, Hash
			before_save :set_last_used_passwords, :if => :password_present?
		end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.register!
    receiver.send :include, PasswordReusePolicy::InstanceMethods
  end
end
