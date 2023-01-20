module Msip
  class Tipoanexo < ActiveRecord::Base
    include Msip::Basica
    has_many :anexo_caso, foreign_key: "tipoanexo_id", 
      class_name: 'Sivel2Gen::AnexoCaso'
  end
end
