# frozen_string_literal: true

require_relative 'lib/terraspace_hooks/version'

Gem::Specification.new do |spec|
  spec.name = 'terraspace_hooks'
  spec.version = TerraspaceHooks::VERSION
  spec.authors = ['slamet kristanto']
  spec.email = ['botoksgonzales@gmail.com']

  spec.summary = 'Useful terraspace hook collection (infracost generator, tflint, tf validate)'
  spec.description = 'Useful terraspace hook collection (infracost generator, tflint, tf validate)'
  spec.homepage = 'https://github.com/drselump14/terraspace_hooks'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/drselump14/terraspace_hooks'
  spec.metadata['changelog_uri'] = 'https://github.com/drselump14/terraspace_hooks'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'zeitwerk', '~> 2.6.7'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
