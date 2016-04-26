Gem::Specification.new do |s|
  s.name        = 'aspect_ratio'
  s.version     = '1.0.0'
  s.date        = '2016-04-26'
  s.summary     = 'Image aspect ratio calculation utility'
  s.description = 'Image aspect ratio calculation utility'
  s.authors     = ['Trung Lê']
  s.email       = 'trung.le@ruby-journal.com'
  s.files       = ['lib/aspect_ratio.rb']
  s.homepage    = 'http://github.com/envato/aspect_ratio'
  s.license     = 'MIT'

  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.2.0'
  s.test_files    = spec.files.grep(%r{^(test)/})
end
