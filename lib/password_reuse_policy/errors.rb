module NoMongoid
  class DocumentError < StandardError
  end
end

class PasswordReusePolicy::ActiveRecodNotFoundError < StandardError; end;
class PasswordReusePolicy::ActiveRecodNotInherited < StandardError; end;
