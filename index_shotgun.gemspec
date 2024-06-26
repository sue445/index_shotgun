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
  spec.metadata["documentation_uri"] = "https://sue445.github.io/index_shotgun/"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.required_ruby_version = ">= 2.5.0"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6.0.0"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "onkcop", "1.0.0.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake_shared_context", "0.2.2"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rubocop", "1.28.2"
  spec.add_development_dependency "rubocop_auto_corrector", "< 0.4.4" # FIXME: rubocop --autocorrect doesn't available on rubocop 1.28.2
  spec.add_development_dependency "yard"
end
