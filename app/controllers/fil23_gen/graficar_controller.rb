# encoding: UTF-8

module Fil23Gen
  class GraficarController < ApplicationController

    def victimizaciones_por_sexo
      authorize! :contar, Sivel2Gen::Caso

      @rutacsv = File.join(Rails.root, 'lib/R/victimizaciones_individuales.csv').to_s

      tarc = Tempfile.new(['victimizaciones_individuales', '.csv'], '/var/www/tmp/')
      rutatmp = tarc.path
      tarc.close
      tarc.unlink
      sql = "COPY (SELECT DISTINCT acto.id_caso AS caso_id, " \
        "caso.fecha, " \
        "supracategoria.id_tviolencia AS tviolencia_id," \
        "categoria.id AS categoria_id, " \
        "categoria.nombre AS categoria_nombre, " \
        "supracategoria.id_tviolencia || categoria.id || ' ' || categoria.nombre AS categoria_rotulo, " \
        "acto.id_persona AS persona_id, " \
        "persona.sexo AS sexonac, " \
        "victima.id_rangoedad AS rangoedad_id, " \
        "rangoedad.nombre AS rangoedad_nombre, " \
        "victima.id_filiacion AS filiacion_id, " \
        "filiacion.nombre AS filiacion_nombre, " \
        "victima.id_organizacion AS organizacion_id, " \
        "organizacion.nombre AS organizacion_nombre, " \
        "victima.id_profesion AS profesion_id, " \
        "profesion.nombre AS profesion_nombre, " \
        "victima.id_sectorsocial AS sectorsocial_id, " \
        "sectorsocial.nombre AS sectorsocial_nombre, " \
        "ubicacion.id_departamento AS departamento_id, " \
        "ubicacion.id_municipio AS municipio_id " \
        "FROM  sivel2_gen_acto AS acto " \
        "JOIN sivel2_gen_caso AS caso ON caso.id = acto.id_caso " \
        "JOIN sivel2_gen_categoria AS categoria ON categoria.id=acto.id_categoria " \
        "JOIN sivel2_gen_supracategoria AS supracategoria ON supracategoria.id = categoria.supracategoria_id " \
        "JOIN sip_persona AS persona ON persona.id = acto.id_persona " \
        "JOIN sivel2_gen_victima AS victima ON " \
        "  victima.id_caso=acto.id_caso AND " \
        "  victima.id_persona=acto.id_persona " \
        "JOIN sivel2_gen_rangoedad AS rangoedad ON rangoedad.id = victima.id_rangoedad " \
        "JOIN sivel2_gen_filiacion AS filiacion ON filiacion.id = victima.id_filiacion " \
        "JOIN sivel2_gen_organizacion AS organizacion ON organizacion.id = victima.id_organizacion " \
        "JOIN sivel2_gen_profesion AS profesion ON profesion.id = victima.id_profesion " \
        "JOIN sivel2_gen_sectorsocial AS sectorsocial ON sectorsocial.id = victima.id_sectorsocial " \
        "LEFT JOIN sip_ubicacion AS ubicacion ON ubicacion.id=caso.ubicacion_id)" \
        " TO '#{rutatmp}' DELIMITER ',' CSV HEADER;" 
      res = ActiveRecord::Base.connection.execute(sql)
      if File.exist?(@rutacsv)
        File.unlink(@rutacsv)
      end
      FileUtils.cp(rutatmp, @rutacsv)
      if ENV['fil23_gen_servidor'].nil?
        flash[:error] = "No se ha definidio fil23_gen_servidor"
        redirect_to Railsc.config.relative_ulr_root
        return
      end
      @fil23_gen_op = {
        servidor: ENV['fil23_gen_servidor'],
        ip: ENV['fil23_gen_ip'],
        puerto: ENV['fil23_gen_puerto'],
        protocolo: ENV['fil23_gen_protocolo'],
        guionR: 'lib/R/victimizaciones_por_sexo.R',
        rutacsv: @rutacsv
      }
      render 'fil23_gen/graficar/graficar', layout: 'application'
    end

  end

end
