# encoding: UTF-8
require_dependency "sip/concerns/controllers/orgsociales_controller"

module Sip
  class OrgsocialesController < Sip::ModelosController
    include Sip::Concerns::Controllers::OrgsocialesController

          def atributos_index
            [ :id, 
              :grupoper_id,
              :fechafundacion
            ]
          end

  end
end
