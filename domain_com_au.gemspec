
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "domain_com_au/version"

Gem::Specification.new do |spec|
  spec.name          = "domain_com_au"
  spec.version       = DomainComAu::VERSION
  spec.authors       = ["Joshua Wilkosz"]
  spec.email         = ["joshua@wilkosz.com.au"]
  spec.summary       = %q{Ruby client for domain.com.au api}
  spec.description   = %q{Provides wrapper class for retrieving domain.com.au resources}
  spec.homepage      = "https://github.com/wilkosz/domain_com_au"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
