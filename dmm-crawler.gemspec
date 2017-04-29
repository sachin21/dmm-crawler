lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmm-crawler/version'

Gem::Specification.new do |spec|
  spec.name          = 'dmm-crawler'
  spec.version       = DMMCrawler::VERSION
  spec.authors       = ['Satoshi Ohmori']
  spec.email         = ['sachin21dev@gmail.com']

  spec.summary       = "Show DMM and DMM.R18's crawled data"
  spec.description   = "Show DMM and DMM.R18's crawled data. e.g. ranking"
  spec.homepage      = 'https://github.com/sachin21/dmm-crawler'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mechanize'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.47'
  spec.add_development_dependency 'pry', '0.10.4'
  spec.add_development_dependency 'rspec', '3.5.0'
end
