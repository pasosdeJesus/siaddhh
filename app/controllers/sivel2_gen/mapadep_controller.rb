
module Sivel2Gen
  class MapadepController < ApplicationController

    def victimizaciones
      puts params
      respond_to do |format|
        format.html { render 'mapadep_victimizaciones', layout: 'application' }
      end
    end

  end
end
