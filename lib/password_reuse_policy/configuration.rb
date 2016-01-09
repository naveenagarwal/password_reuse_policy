require 'digest'

module PasswordReusePolicy

  class Configuration

    class << self

      def default!
        password_attribute_name = :password
        unuse_last_passwords = 3
      end

      def config
        yield self
      end

      def password_attribute_name
        @password_attribute_name ||= :password
      end

      def password_attribute_name=(name)
        @password_attribute_name = name.to_sym
      end

      def unuses_last_passwords
        @unuse_last_passwords ||= 3
      end

      def unuses_last_passwords=(number)
        @unuse_last_passwords = number
      end

    end

  end

end
