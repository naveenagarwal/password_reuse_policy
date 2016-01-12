require 'digest'

module PasswordReusePolicy

  class Configuration

    class << self

      def default!
        password_attribute_name = :password
        number_of_passwords_cannot_be_used = 3
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

      def number_of_passwords_cannot_be_used
        @number_of_passwords_cannot_be_used ||= 3
      end

      def number_of_passwords_cannot_be_used=(number)
        @number_of_passwords_cannot_be_used = number
      end

    end

  end

end
