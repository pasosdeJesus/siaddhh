require 'sivel2_gen/concerns/controllers/casos_controller'
require 'csv'

module Sivel2Gen
  class CasosController < Heb412Gen::ModelosController

    include Sivel2Gen::Concerns::Controllers::CasosController

    before_action :set_caso, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Sivel2Gen::Caso, 
      except: [:index, :show, :mapaosm, :update]

    def campoord_inicial
      'fechadesc'
    end

    def inicializa_index
      ## No autenticados ven solo casos que sean perder la vida
      if !current_usuario 
        cats = [10, 20, 30, 40, 50, 87, 97, 701, 703]
        ##Categorias que sean perder la vida
        casos_actuales = @conscaso
        @conscaso = casos_actuales.joins(:acto).where(acto: {categoria_id: cats}) 
      end

      @plantillas = Heb412Gen::Plantillahcm.where(vista: 'Caso').
        select('nombremenu, id').map { |c| 
          [c.nombremenu, c.id] 
        }
      @plantillas += [
          ['Reporte Revista HTML', 'reprevista.html'],
          ['Reporte Revista no bélicas HTML', 'reprevistanobelicas.html'],
          ['Reporte General HTML', 'repgeneral.html'],
          ['Exportar a JSON', 'reprevista.json']]

    end

    def presenta_mas_index(formato)
      formato.csv {
        atributos = %w{caso_id fecha ubicaciones victimas presponsables tipificacion memo}
        r = CSV.generate(headers: true) do |csv|
          csv << atributos
          @conscaso.try(:each) do |caso|
            csv << atributos.map{ |atr| caso.send(atr) }
          end
        end
        send_data r, filename: "casos-somosdefensores.csv" 
      }
    end
    
    def update
      if params[:caso] && params[:caso][:victimacolectiva_attributes]
        params[:caso][:victimacolectiva_attributes].each { |i,v|
          if v[:orgsocial_attributes] && 
            v[:orgsocial_attributes][:grupoper_id] &&
            v[:grupoper_attributes] && v[:grupoper_attributes][:id]
            v[:orgsocial_attributes][:grupoper_id]=v[:grupoper_attributes][:id]
          end
        }
      end
      @caso.victimacolectiva.each do |v|
        if !v.grupoper
          puts "Victima colectiva debería tener grupoper"
          exit 1
        end
        if v.grupoper && !v.orgsocial
          v.orgsocial = Msip::Orgsocial.new
        end
        if v.grupoper.id != v.orgsocial.grupoper_id
          v.orgsocial.grupoper_id=v.grupoper.id
          v.save!(validate: false)
        end
      end
      update_gen
    end

    def campos_filtro1_gen
      campos_filtro1 + [:profesion_id] + [:editadopor_id]
    end
 
    def caso_params
      # Añadimos orgsocial en victima colectiva
      lp = lista_params
      hlp = lp[lp.length - 1] # Los primeros son escalares, el ultimo hash
      if hlp && hlp[:victimacolectiva_attributes]
        vc = hlp[:victimacolectiva_attributes]
        hvc = vc[vc.length - 1]
        hvc[:orgsocial_attributes] = [:id, :grupoper_id, :fechafundacion]
        # Añadimos otraorg y tipoamenza en victima
        v = hlp[:victima_attributes] = [:otraorganizacion, :tipoamenaza_id] + 
          hlp[:victima_attributes]
        # Añadimos tipoanexo a anexocaso
        ac = hlp[:anexo_caso_attributes] = [:tipoanexo_id] + 
          hlp[:anexo_caso_attributes]
      end
      # Añadimos org social en persona
      hv = v[v.length - 1]
      if hv && hv[:persona_attributes]
        p = hv[:persona_attributes]
        p << { orgsocial_persona_attributes: 
               [:id, :orgsocial_id, :perfilorgsocial_id] }
      end
      params.require(:caso).permit(lp)
    end
       
  end
end
