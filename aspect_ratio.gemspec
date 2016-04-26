lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'aspect_ratio'
  s.version     = '1.0.0'
  s.date        = '2016-04-26'
  s.summary     = 'Image aspect ratio calculation utility'
  s.description = 'Image aspect ratio calculation utility'
  s.authors     = ['Trung Lê']
  s.email       = 'trung.le@ruby-journal.com'
  s.files       = `git ls-files -z -- lib/* LICENSE README.md aspect_ratio.gemspec`.split("\x0")
  s.homepage    = 'http://github.com/envato/aspect_ratio'
  s.license     = 'MIT'

  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.2.0'
  s.test_files    = s.files.grep(%r{^(test)/})

  s.add_development_dependency 'minitest',          '~> 5'
end
