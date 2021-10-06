module Sip
  class Tipoanexo < ActiveRecord::Base
    include Sip::Basica
    has_many :anexo_caso, class_name: 'Sip::AnexoCaso'
  end
end
