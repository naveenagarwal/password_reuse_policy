# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'password_reuse_policy/version'

Gem::Specification.new do |spec|
  spec.name          = "password_reuse_policy"
  spec.version       = PasswordReusePolicy::VERSION
  spec.authors       = ["Naveen Agarwal"]
  spec.email         = ["naveenagarwal287@gmail.com"]

  spec.summary       = %q{Setup password resuse policy for your app.}
  spec.description   = %q{You can setup the check when a password can be reused by a user. It lets you configure the last 'n' password can not be used by user when they change it.}
  spec.homepage      = "https://github.com/naveenagarwal/password_reuse_policy"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mongoid", "~> 5.0.0"
  spec.add_development_dependency 'activerecord', '~> 4.2'
  spec.add_development_dependency 'sqlite3', '~> 1.3.11'
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
end
