# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'practica9/version'

Gem::Specification.new do |spec|
  spec.name          = "practica9"
  spec.version       = Practica9::VERSION
  spec.authors       = ["Hector"]
  spec.email         = ["alu0100608939@ull.edu.es"]
  spec.description   = %q{Jerarquia de clases para matrices}
  spec.summary       = %q{Jerarquia para la definicion de matrices, tanto densas como dispersas}
  spec.homepage      = "https://github.com/alu0100608939/prct09.git"
  

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
