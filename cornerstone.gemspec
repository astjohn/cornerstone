Gem::Specification.new do |s|
  s.author = "Adam St. John"
  s.email  = "astjohn@gmail.com"
  s.date    = Date.today.to_s
  s.name    = "cornerstone"
  s.summary = "A rails engine for customer care."
  s.description = "Cornerstone provides customer care capabilities to an existing" \
                  " application by adding things like discussions and a knowledge base."
  s.files = `git ls-files`.split("\n")
  s.version  = IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths    = ["lib"]


  #s.add_dependency('rails',  '>= 3.1.0.rc4')

  s.add_development_dependency('bundler', '~> 1.0.0')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('rspec-rails')
  s.add_development_dependency('factory_girl_rails')
  s.add_development_dependency('devise')

end

