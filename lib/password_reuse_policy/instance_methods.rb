module PasswordReusePolicy::InstanceMethods
  private

  def password_present?
    send(PasswordReusePolicy::Configuration.password_field_name).present?
  end

  def set_last_used_passwords
    n = PasswordReusePolicy::Configuration.number_of_passwords_cannot_be_used
    return false if n < 1

    encryption = PasswordReusePolicy::Configuration.encryption
    new_password = encryption.hexdigest public_send(PasswordReusePolicy::Configuration.password_field_name)

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
