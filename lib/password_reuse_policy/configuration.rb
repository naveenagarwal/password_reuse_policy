require 'digest'

module PasswordReusePolicy

  class Configuration

    class << self

      def default!
        password_attribute_name = :encrypted_password
        number_of_passwords_cannot_be_used = 3
      end

      def config
        yield self
      end

      def password_attribute_name
        @password_attribute_name ||= :encrypted_password
      end

      def password_attribute_name=(name)
        @password_attribute_name = name.to_sym
      end

      def number_of_passwords_cannot_be_used
        @number_of_passwords_cannot_be_used ||= 3
      end

      def number_of_passwords_cannot_be_used=(number)
        @number_of_passwords_cannot_be_used = number
      end

      def error_field_name
        @error_field_name ||= :password
      end

      def error_field_name=(name)
        @error_field_name = name.to_sym
      end

    end

  end

end
