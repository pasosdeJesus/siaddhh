require 'sivel2_gen/concerns/controllers/mapadep_controller'

module Sivel2Gen
  class MapadepController < ApplicationController

    # Especial, cada función debe tener autorización
    include Sivel2Gen::Concerns::Controllers::MapadepController

    def ajusta_titulos(pFini, pFfin, pTviolencia, pEtiqueta1,
                       pEtiqueta2, pColormax)

      @mapadep_titulo = 'Agresiones a personas defensoras de derechos humanos'
      if pTviolencia != ''
        @mapadep_titulo += 
          " (#{Sivel2Gen::Tviolencia.find(pTviolencia).nomcorto})"
      end
      @mapadep_titulorangos = 'Rango de agresiones'
      @mapadep_fuente = 'Fuente: SIADDHH https://www.somosdefensores.org/siaddhh/'
    end


  end
end
