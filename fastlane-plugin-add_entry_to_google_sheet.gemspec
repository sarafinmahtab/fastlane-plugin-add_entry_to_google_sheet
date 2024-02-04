lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/add_entry_to_google_sheet/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-add_entry_to_google_sheet'
  spec.version       = Fastlane::AddEntryToGoogleSheet::VERSION
  spec.author        = 'Shamsul Arafin Mahtab'
  spec.email         = 'shamsul.arafin@therapservices.net'

  spec.summary       = 'A lane created to add a row in Google sheet.'
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-add_entry_to_google_sheet"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'
end
