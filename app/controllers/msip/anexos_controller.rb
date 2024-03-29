require 'sivel2_gen/concerns/controllers/anexos_controller' 

module Msip
  class AnexosController < Msip::ModelosController

    load_and_authorize_resource class: Msip::Anexo, except: :descarga_anexo
    include Sivel2Gen::Concerns::Controllers::AnexosController
  end
end


#    def descarga_anexo_gen
#      if !params[:id].nil?
#        @anexo = Anexo.find(params[:id].to_i)
#        ruta = @anexo.adjunto_file_name
#        if !ruta.nil?
#          # Idea para evitar inyeccion de https://www.ruby-forum.com/topic/124471
#          n=sprintf(Msip.ruta_anexos.to_s + "/%d_%s", @anexo.id.to_i, 
#                    File.basename(ruta))
#          logger.debug "Descargando #{n}"
#          send_file n, x_sendfile: true
#        else
#          redirect_to usuarios_url
#        end
#      end
#    end
#    def descarga_anexo
#      anexo_caso = Sivel2Gen::AnexoCaso.where(anexo_id: params[:id])
#      if anexo_caso[0].tipoanexo
#        tipoanexo = anexo_caso[0].tipoanexo.id
#        if tipoanexo == 2
#          authorize! :fotopublica, Sivel2Gen::Caso
#          descarga_anexo_gen
#          return
#        end
#      end
#      authorize! :descarga_anexo, Msip::Anexo
#      descarga_anexo_gen
#    end
#
#  end
#end
