require 'sivel2_gen/concerns/controllers/conteos_controller'

module Sivel2Gen
  class ConteosController < ApplicationController

    load_and_authorize_resource class: Sivel2Gen::Caso
    include Sivel2Gen::Concerns::Controllers::ConteosController

    def personas_arma_filtros
      f = personas_arma_filtros_sivel2_gen
      f.delete(
        Sivel2Gen::Victima.human_attribute_name(:vinculoestado).upcase)
      f.delete('FILIACIÓN')
      
      return f
    end

  end
end
