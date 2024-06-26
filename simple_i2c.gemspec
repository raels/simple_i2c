# frozen_string_literal: true

require_relative "lib/simple_i2c/version"

Gem::Specification.new do |spec|
  spec.name = "simple_i2c"
  spec.version = SimpleI2c::VERSION
  spec.authors = ["Raels Koder"]
  spec.email = ["raels@uniblab.com"]

  spec.summary = "A simple extensible framework for Raspberry Pi I2C."
  spec.description = "A simple extensible framework for Raspberry Pi I2C"
  spec.homepage = "https://github.com/raels/simple_i2c"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "github_changelog_generator", "~> 1.16"
  # spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
