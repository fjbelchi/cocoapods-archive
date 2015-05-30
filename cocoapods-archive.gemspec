# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-archive/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-archive'
  spec.version       = CocoapodsArchive::VERSION
  spec.authors       = ['fjbelchi', 'alexito4']
  spec.email         = ['fjbelchi@gmail.com', 'alexito4@gmail.com']
  spec.description   = %q{cocoapods-archive plugin that archive your project}
  spec.homepage      = 'https://github.com/fjbelchi/cocoapods-archive'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
