
require 'sivel2_gen/concerns/models/conscaso'

module Sivel2Gen 
  class Conscaso < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Conscaso

    scope :filtro_editadopor_id, lambda { |id|
      where("caso_id IN (SELECT caso_id
              FROM public.sivel2_gen_conscaso AS conscaso
              JOIN sip_bitacora AS bita ON bita.modelo_id = conscaso.caso_id
              WHERE bita.modelo = 'Sivel2Gen::Caso' AND bita.usuario_id = ?)", id)
    }

  end
end
