class Tipoamenaza < ActiveRecord::Base
  include Sip::Basica

  has_many :victima, class_name: 'Sivel2Gen::Victima'
end
