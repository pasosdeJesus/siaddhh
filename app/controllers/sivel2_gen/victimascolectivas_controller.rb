require 'date'

require "sivel2_gen/concerns/controllers/victimascolectivas_controller.rb"

module Sivel2Gen
  class VictimascolectivasController < ApplicationController

    include Sivel2Gen::Concerns::Controllers::VictimascolectivasController

    load_and_authorize_resource class: Sivel2Gen::Victimacolectiva
    before_action :prepara_caso


    # Crea un nuevo registro para el caso que recibe por parametro 
    # params[:caso_id].  Pone valores simples en los campos requeridos
    def nuevo
      if params[:caso_id]
        @grupoper = Msip::Grupoper.new
        @victimacolectiva = Victimacolectiva.new
        @grupoper.nombre = 'N'
        if !@grupoper.save
          respond_to do |format|
            format.html { render inline: 'No pudo crear grupoper' }
          end
          return
        end
        @orgsocial = Msip::Orgsocial.new
        @orgsocial.grupoper_id = @grupoper.id
        @orgsocial.save!
        @victimacolectiva.caso_id = params[:caso_id]
        @victimacolectiva.grupoper_id = @grupoper.id
        @victimacolectiva.orgsocial_id = @orgsocial.id
        if @victimacolectiva.save
          respond_to do |format|
            format.js { render json: {
              'victimacolectiva' => @victimacolectiva.id.to_s,
              'grupoper' => @grupoper.id.to_s,
              'orgsocial' => @orgsocial.id.to_s } }
            format.json { render json: {
              'victimacolectiva' => @victimacolectiva.id.to_s,
              'grupoper' => @grupoper.id.to_s,
              'orgsocial' => @orgsocial.id.to_s }, status: :created }
            format.html { render json: {
              'victimacolectiva' => @victimacolectiva.id.to_s,
              'grupoper' => @grupoper.id.to_s,
              'orgsocial' => @orgsocial.id.to_s } }
          end
        else
          respond_to do |format|
            format.html { render action: "error" }
            format.json { render json: @victimacolectiva.errors, 
                          status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { render inline: 'Falta identificacion del caso' }
        end
      end
    end
  end
end
