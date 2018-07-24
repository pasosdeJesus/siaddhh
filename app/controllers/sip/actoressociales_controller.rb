# encoding: UTF-8
require_dependency "sip/concerns/controllers/actoressociales_controller"

module Sip
  class ActoressocialesController < Sip::ModelosController
    include Sip::Concerns::Controllers::ActoressocialesController

          def atributos_index
            [ :id, 
              :grupoper_id,
              :fechafundacion
            ]
          end

  end
end
