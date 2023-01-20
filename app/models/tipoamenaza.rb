class Tipoamenaza < ActiveRecord::Base
  include Msip::Basica

  has_many :victima, class_name: 'Sivel2Gen::Victima'
end
