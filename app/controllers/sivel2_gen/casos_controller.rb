# encoding: UTF-8

require 'sivel2_gen/concerns/controllers/casos_controller'

module Sivel2Gen
  class CasosController < ApplicationController

    include Sivel2Gen::Concerns::Controllers::CasosController

    def campoord_inicial
      'fechadesc'
    end

    def inicializa_index
      @plantillas = Heb412Gen::Plantillahcm.where(
        vista: 'Caso').select('nombremenu, id').map { |c| 
          [c.nombremenu, c.id] 
        }
    end

    def update
      if params[:caso] && params[:caso][:victimacolectiva_attributes]
        params[:caso][:victimacolectiva_attributes].each { |i,v|
          v[:actorsocial_attributes][:grupoper_id]=v[:grupoper_attributes][:id]
        }
      end
      @caso.victimacolectiva.each do |v|
        if !v.grupoper
          puts "Victima colectiva debería tener grupoper"
          exit 1
        end
        if v.grupoper && !v.actorsocial
          v.actorsocial = Sip::Actorsocial.new
        end
        if v.grupoper.id != v.actorsocial.grupoper_id
          v.actorsocial.grupoper_id=v.grupoper.id
          v.save!(validate: false)
        end
      end
      update_gen
    end

    def caso_params
      # Añadimos actorsocial
      lp = lista_params
      hlp = lp[lp.length - 1] # Los primeros son escalares, el ultimo hash
      vc = hlp[:victimacolectiva_attributes]
      hvc = vc[vc.length - 1]
      hvc[:actorsocial_attributes] = [:id, :grupoper_id, :fechafundacion]
      v = hlp[:victima_attributes]
      hv = v[v.length - 1]
      p = hv[:persona_attributes]
      p << { actorsocial_persona_attributes: 
             [:id, :actorsocial_id, :perfilactorsocial_id] }
      params.require(:caso).permit(lp)
    end
       
  end
end
