# frozen_string_literal: true

require_relative "lib/memplify/version"

Gem::Specification.new do |spec|
  spec.name = "memplify"
  spec.version = Memplify::VERSION
  spec.authors = ["Tomasz Kowalewski"]
  spec.email = ["me@tkowalewski.pl"]

  spec.summary = "Memplify reporter for memory_profiler"
  spec.homepage = "https://memplify.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tkowalewski/memplify"
  spec.metadata["changelog_uri"] = "https://github.com/tkowalewski/memplify/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "base64", "~> 0.2.0"
  spec.add_dependency "json", "~> 2.10", ">= 2.10.1"
  spec.add_dependency "memory_profiler", "~> 1.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
