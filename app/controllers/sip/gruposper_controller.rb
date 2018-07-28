# encoding: UTF-8
require 'date'
require 'sivel2_gen/concerns/controllers/gruposper_controller' 

module Sip
  class GruposperController < ApplicationController
    include Sivel2Gen::Concerns::Controllers::GruposperController
   
    # Busca y lista grupo(s) de persona
    def remplazar_antes_salvar_vc
      @actorant = @victimacolectiva.actorsocial
      @actorsocial = Sip::Actorsocial.
        where(grupoper_id: @grupoper.id).order(:id).first
      @victimacolectiva.actorsocial = @actorsocial
    end

    def remplazar_antes_destruir_gp
        @actorant.destroy
    end


  end
end
