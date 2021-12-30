# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_in_sequence/version'

Gem::Specification.new do |spec|
  spec.name          = 'acts_in_sequence'
  spec.version       = ActsInSequence::VERSION
  spec.authors       = ['Sandip Mane']
  spec.email         = ['sandip2490@gmail.com']

  spec.summary       = 'Adds sequencing abilities to the ActiveRecord Models.'
  spec.description   = 'A light-weight simple to use gem to manage sequencing of records in the database. Check the homepage for more information.'
  spec.homepage      = "https://github.com/bigbinary/acts_in_sequence"
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "https://github.com/bigbinary/acts_in_sequence"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
end
