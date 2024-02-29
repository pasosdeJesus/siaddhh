require 'sivel2_gen/concerns/controllers/personas_controller' 

module Msip
  class PersonasController < Msip::ModelosController

    include Sivel2Gen::Concerns::Controllers::PersonasController

    load_and_authorize_resource class: Msip::Persona

    # Busca y lista persona
    def remplazar_antes_salvar_v
      true
    end

    def remplazar_antes_destruir_p
      Msip::OrgsocialPersona.where(persona_id: @personaant.id).
        where(orgsocial_id: nil).destroy_all
      true
    end


  end
end
