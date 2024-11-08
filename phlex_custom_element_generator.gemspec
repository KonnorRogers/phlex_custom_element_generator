# frozen_string_literal: true

require_relative "lib/phlex_custom_element_generator/version"

Gem::Specification.new do |spec|
  spec.name = "phlex_custom_element_generator"
  spec.version = PhlexCustomElementGenerator::VERSION
  spec.authors = ["Konnor Rogers"]
  spec.email = ["konnor5456@gmail.com"]

  spec.summary = "A way to generate Phlex components from a custom element manifest"
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/konnorrogers/phlex_custom_element_generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/konnorrogers/phlex_custom_element_generator"
  spec.metadata["changelog_uri"] = "https://github.com/konnorrogers/phlex_custom_element_generator/tree/main/CHANGELOG.md"

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
  spec.add_dependency "prompts", "~> 0.3"

  # Locked until this is fixed: https://github.com/fractaledmind/prompts/issues/8
  spec.add_dependency "thor"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
