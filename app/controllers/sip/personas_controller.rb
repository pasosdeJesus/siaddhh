require 'date'
require 'sivel2_gen/concerns/controllers/personas_controller' 

module Sip
  class PersonasController < ApplicationController

    load_and_authorize_resource class: Sip::Persona
    include Sivel2Gen::Concerns::Controllers::PersonasController
   
    # Busca y lista persona
    def remplazar_antes_salvar_v
      true
    end

    def remplazar_antes_destruir_p
      Sip::OrgsocialPersona.where(persona_id: @personaant.id).
        where(orgsocial_id: nil).destroy_all
      true
    end


  end
end
