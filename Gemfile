source 'https://rubygems.org'

ruby '>=2.4'


gem 'bcrypt'

gem 'bigdecimal'

gem 'bootsnap', '>=1.1.0', require: false

gem 'cancancan'

gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax' # Formularios anidados (algunos con ajax)

gem 'coffee-rails', '>= 5.0.0' # CoffeeScript para recuersos .js.coffee y vistas

gem 'devise' , '>= 4.7.2' # Autenticación 

gem 'devise-i18n', '>= 1.9.2'

gem 'jbuilder' # API JSON facil. 

gem 'libxml-ruby'

gem 'odf-report' # Genera ODT

gem 'paperclip' # Maneja adjuntos

gem 'pg' # Postgresql

gem 'puma'

gem 'prawn' # Generación de PDF

gem 'prawnto_2', '>= 0.3.0', :require => 'prawnto'

gem 'prawn-table'

gem 'rails', '~> 6.0.3.3'

gem 'rails-i18n', '>= 6.0.0'

gem 'redcarpet'

gem  'rinruby'

gem 'rspreadsheet'

gem 'rubyzip', '>=2.0.0'

gem 'sassc-rails' , '>= 2.1.2' # CSS

gem 'simple_form' , '>= 5.0.2' # Formularios simples 

gem 'turbolinks' # Seguir enlaces más rápido. Ver: https://github.com/rails/turbolinks

gem 'twitter_cldr' # ICU con CLDR

gem 'tzinfo' # Zonas horarias

gem 'webpacker', '>= 5.2.1'

gem 'will_paginate' # Listados en páginas


#####
# Motores que se sobrecargan vistas (deben ponerse en orden de apilamiento 
# lógico y no alfabetico como las gemas anteriores) 

gem 'sip', # Motor generico
  git: 'https://github.com/pasosdeJesus/sip.git'
  #path: '../sip'

gem 'mr519_gen', # Motor de gestion de formularios y encuestas
  git: 'https://github.com/pasosdeJesus/mr519_gen.git'
  #path: '../mr519_gen'

gem 'heb412_gen',  # Motor de nube y llenado de plantillas
  git: 'https://github.com/pasosdeJesus/heb412_gen.git'
  #path: '../heb412_gen'

gem 'sivel2_gen', # Motor Cor1440_gen
  git: 'https://github.com/pasosdeJesus/sivel2_gen.git'
  #path: '../sivel2_gen'


group :development do

  gem 'web-console' , '>= 4.0.4' # Consola irb en páginas 

end


group :development, :test do
  
  #gem 'byebug' # Depurar

  gem 'colorize' # Color en terminal
  
end


group :test do
  
  gem 'capybara'

  gem 'selenium-webdriver'

  gem 'simplecov'

  gem 'spring' # Acelera ejecutando en fondo.  

end


group :production do
  
  gem 'unicorn' # Para despliegue

end

