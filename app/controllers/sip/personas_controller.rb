# encoding: UTF-8
require 'date'
require 'sivel2_gen/concerns/controllers/personas_controller' 

module Sip
  class PersonasController < ApplicationController
    include Sivel2Gen::Concerns::Controllers::PersonasController
   
    # Busca y lista persona
    def remplazar_antes_salvar_v
      @actorpant = Sip::ActorsocialPersona.where(
        persona_id: @victima.persona.id).where(actorsocial_id: nil).take
    end

    def remplazar_antes_destruir_p
      if @actorpant
        @actorpant.destroy
      end
    end


  end
end
