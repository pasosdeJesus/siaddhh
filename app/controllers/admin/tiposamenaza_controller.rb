# encoding: UTF-8

module Admin
  class TiposamenazaController < Sip::Admin::BasicasController
    before_action :set_tipoamenaza, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Tipoamenaza

    def clase 
      "::Tipoamenaza"
    end

    def set_tipoamenaza
      @basica = Tipoamenaza.find(params[:id])
    end

    def atributos_index
      [
        "id", 
        "nombre", 
        "observaciones", 
        "fechacreacion_localizada", 
        "habilitado"
      ]
    end

    def genclase
      'M'
    end

    def tipoamenaza_params
      params.require(:tipoamenaza).permit(*atributos_form)
    end

  end
end
