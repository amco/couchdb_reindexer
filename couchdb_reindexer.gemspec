# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "couchdb_reindexer/version"

Gem::Specification.new do |spec|
  spec.name          = "couchdb_reindexer"
  spec.version       = CouchdbReindexer::VERSION
  spec.authors       = ["Jesus Urias"]
  spec.email         = ["itsjesusurias@gmail.com"]

  spec.summary       = 'CouchDB indexer'
  spec.description   = 'Simple CouchDB views reindexer'
  spec.homepage      = 'https://github.com/itsjesusurias/couch_reindexer'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
