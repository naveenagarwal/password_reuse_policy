require 'digest'

module PasswordReusePolicy

  class Configuration

    class << self

      def default!
        self.number_of_passwords_cannot_be_used = 3
	      self.error_field_name = :password
        self.password_field_name = :password
      end

      def config
        yield self
      end

      def password_field_name
        @password_field_name
      end

      def password_field_name=(name)
	      @password_field_name = name.to_sym
      end

      def number_of_passwords_cannot_be_used
        @number_of_passwords_cannot_be_used
      end

      def number_of_passwords_cannot_be_used=(number)
        @number_of_passwords_cannot_be_used = number
      end

      def error_field_name
        @error_field_name
      end

      def error_field_name=(name)
        @error_field_name = name.to_sym
      end

      def encryption
	      Digest::MD5
      end
    end

  end

end
