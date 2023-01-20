require_dependency "msip/concerns/controllers/orgsociales_controller"

module Msip
  class OrgsocialesController < Msip::ModelosController

    before_action :set_orgsocial, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Msip::Orgsocial

    include Msip::Concerns::Controllers::OrgsocialesController

    def atributos_index
      [ :id, 
        :grupoper_id,
        :fechafundacion
      ]
    end

  end
end
