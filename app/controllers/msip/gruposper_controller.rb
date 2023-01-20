require 'date'
require 'sivel2_gen/concerns/controllers/gruposper_controller' 

module Msip
  class GruposperController < ApplicationController

    load_and_authorize_resource class: Msip::Grupoper
    include Sivel2Gen::Concerns::Controllers::GruposperController
   
    # Busca y lista grupo(s) de persona
    def remplazar_antes_salvar_vc
      @orgsocialant = @victimacolectiva.orgsocial
      @orgsocial = Msip::Orgsocial.
        where(grupoper_id: @grupoper.id).order(:id).first
      @victimacolectiva.orgsocial = @orgsocial
    end

    def remplazar_antes_destruir_gp
        @orgsocialant.destroy
    end


  end
end
