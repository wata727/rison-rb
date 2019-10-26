lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rison/version"

Gem::Specification.new do |spec|
  spec.name          = "rison-rb"
  spec.version       = Rison::VERSION
  spec.authors       = ["Kazuma Watanabe"]
  spec.email         = ["watassbass@gmail.com"]

  spec.summary       = %q{A Ruby implementation for Rison}
  spec.description   = %q{This is a Ruby implementation for Rison that represents compact data in URIs. This module provides a parsing and dumping API like JSON module.}
  spec.homepage      = "https://github.com/wata727/rison-rb"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/wata727/rison-rb/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "racc", "~> 1.4"
end
