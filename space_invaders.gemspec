# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'space_invaders/version'

Gem::Specification.new do |spec|
  spec.name          = 'space_invaders'
  spec.version       = SpaceInvaders::VERSION
  spec.authors       = ['Gustavo Sobral']
  spec.email         = ['ghsobral@gmail.com']

  spec.summary       = %w[Gem to detect Space Invaiders on radar images]
  spec.homepage      = 'https://github.com/gustavosobral/space_invaders'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
