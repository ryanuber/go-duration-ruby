lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "go-time/version"

Gem::Specification.new do |spec|
  spec.name          = "go-time"
  spec.version       = GoTime::VERSION
  spec.authors       = ["Ryan Uber"]
  spec.email         = ["ru@ryanuber.com"]
  spec.licenses      = ["MIT"]

  spec.summary       = "A parser and formatter for Golang's time.Duration"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ryanuber/go-time-ruby"

  files              = Dir.glob('**/*').reject { |f| File.directory? f }
  spec.files         = files.grep('lib')
  spec.test_files    = files.grep('spec')
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
end
