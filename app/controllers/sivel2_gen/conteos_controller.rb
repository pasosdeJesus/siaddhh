require 'sivel2_gen/concerns/controllers/conteos_controller'

module Sivel2Gen
  class ConteosController < ApplicationController

    # Autorización no estandar por función en clase incluida
    include Sivel2Gen::Concerns::Controllers::ConteosController

    # Llena variables de clase: @opsegun, @titulo_personas,
    # @titulo_personas_fecha y otras nuevas relacionads con filtros
    # (prefijo p)
    def personas_filtros_especializados
      @opsegun =  ["", "ETNIA", #"FILIACIÓN", 
                   "MES CASO", "ORGANIZACIÓN", "PROFESIÓN", 
                   "RANGO DE EDAD", "SECTOR SOCIAL", "SEXO", 
                   Sivel2Gen::Victima.human_attribute_name(:vinculoestado).upcase
      ]
      @titulo_personas = 'Demografía de Víctimas'
      @titulo_personas_fecha = 'Fecha del Caso'
    end

  end
end
