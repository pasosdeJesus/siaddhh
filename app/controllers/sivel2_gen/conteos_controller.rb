require 'sivel2_gen/concerns/controllers/conteos_controller'

module Sivel2Gen
  class ConteosController < ApplicationController

    # Autorización no estandar por función en clase incluida
    include Sivel2Gen::Concerns::Controllers::ConteosController

    # Llena variables de clase: @opsegun, @titulo_personas,
    # @titulo_personas_fecha y otras nuevas relacionads con filtros
    # (prefijo p)
    def personas_filtros_especializados
      @opsegun =  ["", "ETNIA", #"FILIACIÓN", 
                   "MES CASO", "ORGANIZACIÓN", "PROFESIÓN", 
                   "RANGO DE EDAD", "SECTOR SOCIAL", "SEXO", 
                   Sivel2Gen::Victima.human_attribute_name(:vinculoestado).upcase
      ]
      @titulo_personas = 'Demografía de Víctimas'
      @titulo_personas_fecha = 'Fecha del Caso'
    end

    def filtros_victimizaciones_gen(pFini, pFfin, pTviolencia, pEtiqueta1, pEtiqueta2, pExcluirCateRep,
      pSegun, pDepartamento, pMunicipio, pCategoria)
      pCategoria = params[:filtro] ? params[:filtro][:categoria] : Sivel2Gen::Categoria.habilitados.pluck(:id)

      tcons1 = genconsulta_victimizaciones(
        pFini, pFfin, pTviolencia, pEtiqueta1, pEtiqueta2, pExcluirCateRep, pSegun,
        pDepartamento, pMunicipio, pCategoria
      )
      return tcons1
    end

    def genconsulta_victimizaciones(
      pFini, pFfin, pTviolencia, pEtiqueta1, pEtiqueta2, pExcluirCateRep,
      pSegun, pDepartamento, pMunicipio, pCategoria)

      tcons1 = 'cvt1'
      # La estrategia es 
      # 1. Agrupar en la vista tcons1 respuesta con lo que se contará 
      #    con máxima desagregación restringiendo por filtros con códigos 
      # 2. Contar derechos/respuestas tcons1, cambiar códigos
      #    por información por desplegar

      # Para la vista tcons1 emplear que1, tablas1 y where1
      que1 = 'DISTINCT acto.id_caso, acto.id_persona, acto.id_categoria, 
      supracategoria.id_tviolencia AS id_tviolencia, 
      categoria.nombre AS categoria'
      tablas1 = ' public.sivel2_gen_acto AS acto JOIN ' +
      'public.sivel2_gen_caso AS caso ON acto.id_caso=caso.id ' +
      'JOIN public.sivel2_gen_categoria AS categoria ' + 
      ' ON acto.id_categoria=categoria.id ' +
      'JOIN public.sivel2_gen_supracategoria AS supracategoria ' + 
      ' ON categoria.supracategoria_id=supracategoria.id ' +
      'JOIN public.sivel2_gen_victima AS victima ' + 
      ' ON victima.id_persona=acto.id_persona AND ' +
      ' victima.id_caso=caso.id ' +
      'JOIN public.sip_persona AS persona ' + 
      ' ON persona.id=acto.id_persona'
      where1 = ''

      if (pFini != '')
        @fechaini = Sip::FormatoFechaHelper.fecha_local_estandar pFini
        if @fechaini
          where1 = consulta_and(
            where1, "caso.fecha", @fechaini, ">="
          )
        end
      end
      if (pFfin != '') 
        @fechafin = Sip::FormatoFechaHelper.fecha_local_estandar pFfin
        if @fechafin
          where1 = consulta_and(
            where1, "caso.fecha", @fechafin, "<="
          )
        end
      end
      if (pTviolencia != '') 
        where1 = consulta_and(
          where1, "id_tviolencia", pTviolencia[0], "="
        )
      end
      if (!pCategoria.empty? && pCategoria != [""])
        where1 = " categoria.id IN (#{(pCategoria - ['']).join(', ')}) "
      end

      if (pExcluirCateRep == '1')
        cats_repetidas = Sivel2Gen::Categoria.habilitados.where(contadaen: nil).pluck(:id)
        where1 << "acto.id_categoria IN (#{cats_repetidas.join(', ')})"
      end
      if (pEtiqueta1 != '' || pEtiqueta2 != '')
        tablas1 += ' JOIN sivel2_gen_caso_etiqueta AS caso_etiqueta ON' +
          ' caso.id=caso_etiqueta.id_caso' 
        if (pEtiqueta1 != '') 
          where1 = consulta_and(
            where1, "caso_etiqueta.id_etiqueta", pEtiqueta1, "="
          )
        end
        if (pEtiqueta2 != '') 
          where1 = consulta_and(
            where1, "caso_etiqueta.id_etiqueta", pEtiqueta2, "="
          )
        end
      end

      if (pDepartamento.to_i == 1 || pMunicipio.to_i == 1) 
        que1 += ', ubicacion.id_departamento' +
          ', departamento.id_deplocal AS departamento_divipola' +
          ', INITCAP(departamento.nombre) AS departamento_nombre'
        # Tomamos ubicacion principal
        tablas1 += ' LEFT JOIN sip_ubicacion AS ubicacion ON' +
          ' caso.ubicacion_id = ubicacion.id'
        tablas1 += ' LEFT JOIN sip_departamento AS departamento ON ' +
          ' ubicacion.id_departamento=departamento.id'
      end

      if (pMunicipio.to_i == 1) 
        que1 += ', ubicacion.id_municipio' +
          ', INITCAP(municipio.nombre) AS municipio_nombre'
        tablas1 += ' LEFT JOIN sip_municipio AS municipio ON ' +
          ' ubicacion.id_municipio=municipio.id'
      end

      if pSegun && pSegun != ''
        case pSegun
        when "ACTOS PRESUNTOS RESPONSABLES"
          que1 += ', presponsable.id, INITCAP(presponsable.nombre) AS presponsable_nombre' 
          tablas1 += ' LEFT JOIN sivel2_gen_presponsable AS presponsable ON ' +
            ' acto.id_presponsable=presponsable.id'

        when "FILIACIÓN"
          que1 += ', filiacion.id, INITCAP(filiacion.nombre) AS filiacion_nombre' 
          tablas1 += ' LEFT JOIN public.sivel2_gen_filiacion AS filiacion ON ' +
            ' victima.id_filiacion=filiacion.id'

        when "MES CASO"
          que1 += ", TO_CHAR(EXTRACT(YEAR FROM caso.fecha), '0000') || " +
            " '-' || TO_CHAR(EXTRACT(MONTH FROM caso.fecha),'00') " +
            "AS mes_anio" 

        when "ORGANIZACIÓN SOCIAL"
          que1 += ', organizacion.id, INITCAP(organizacion.nombre) AS organizacion_nombre' 
          tablas1 += ' LEFT JOIN public.sivel2_gen_organizacion AS organizacion ON ' +
            ' victima.id_organizacion=organizacion.id'

        when "PROFESIÓN"
          que1 += ', profesion.id, INITCAP(profesion.nombre) AS profesion_nombre' 
          tablas1 += ' LEFT JOIN public.sivel2_gen_profesion AS profesion ON ' +
            ' victima.id_profesion=profesion.id'


        when "RANGO DE EDAD"
          que1 += ', rangoedad.id, INITCAP(rangoedad.nombre) AS rangoedad_rango' 
          tablas1 += ' LEFT JOIN public.sivel2_gen_rangoedad AS rangoedad ON ' +
            ' victima.id_rangoedad=rangoedad.id'

        when "SECTOR SOCIAL"
          que1 += ", sectorsocial.id, "\
            "INITCAP(sectorsocial.nombre) AS sectorsocial_nombre" 
          tablas1 += " LEFT JOIN public.sivel2_gen_sectorsocial "\
            "AS sectorsocial ON victima.id_sectorsocial=sectorsocial.id"

        when "SEXO"
          que1 += ", CASE  WHEN persona.sexo='F' THEN 'Femenino' "\
            "  WHEN persona.sexo='M' THEN 'Masculino' "\
            "  ELSE 'Sin Información' "\
            "END AS sexo"
          tablas1 += " LEFT JOIN public.sivel2_gen_profesion "\
            "AS profesion ON victima.id_profesion=profesion.id"
        end
      end

      if where1 != ''
        where1 = "WHERE #{where1}"
      end
      ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{tcons1}"
      # Filtrar 
      q1="CREATE VIEW #{tcons1} AS 
        SELECT #{que1}
        FROM #{tablas1} #{where1} "
      puts "q1 es #{q1}"
      ActiveRecord::Base.connection.execute q1

      return tcons1
    end # def
  end
end
