# encoding: UTF-8
require 'date'
require 'sip/concerns/controllers/gruposper_controller' 

module Sip
  class GruposperController < ApplicationController
    include Sip::Concerns::Controllers::GruposperController
   
    # Busca y lista grupo(s) de persona
    def remplazar
      byebug
      @grupoper = Sip::Grupoper.find(params[:id_grupoper].to_i)
      @victimacolectiva = Sivel2Gen::Victimacolectiva.find(params[:id_victimacolectiva].to_i)
      grupoperant = @victimacolectiva.grupoper
      actorant = @victimacolectiva.actorsocial
      @actorsocial = Sip::Actorsocial.
        where(grupoper_id: @grupoper.id).order(:id).first
      @caso = @victimacolectiva.caso
      @caso.current_usuario = current_usuario
      @victimacolectiva.grupoper = @grupoper
      @victimacolectiva.actorsocial = @actorsocial
      @victimacolectiva.save!
      if (grupoperant.nombre == 'N') ||
        (grupoperant.nombre == '')
        grupoperant.destroy
      end
      respond_to do |format|
        format.html { render('remplazar', layout: false) }
      end
    end
  end
end
