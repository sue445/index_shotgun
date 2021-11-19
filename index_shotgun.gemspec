lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "index_shotgun/version"

Gem::Specification.new do |spec|
  spec.name          = "index_shotgun"
  spec.version       = IndexShotgun::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = "duplicate index checker"
  spec.description   = "duplicate index checker"
  spec.homepage      = "https://github.com/sue445/index_shotgun"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.required_ruby_version = ">= 2.4.0"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 5.0.0"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "onkcop", "0.53.0.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake_shared_context", "0.2.2"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-power_assert"
  spec.add_development_dependency "rubocop", "0.62.0"
  spec.add_development_dependency "rubocop_auto_corrector"
  spec.add_development_dependency "simplecov", "< 0.18.0"
end
