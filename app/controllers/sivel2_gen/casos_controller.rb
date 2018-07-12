# encoding: UTF-8

require 'sivel2_gen/concerns/controllers/casos_controller'

module Sivel2Gen
  class CasosController < ApplicationController

    include Sivel2Gen::Concerns::Controllers::CasosController

    def campoord_inicial
      'fechadesc'
    end

    def inicializa_index
      @plantillas = Heb412Gen::Plantillahcm.where(
        vista: 'Caso').select('nombremenu, id').map { |c| 
          [c.nombremenu, c.id] 
        }
    end
       
  end
end
