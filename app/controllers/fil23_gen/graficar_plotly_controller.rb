# Grafica con R

module Fil23Gen
  class GraficarPlotlyController < ApplicationController

    # Autorización no estandar por función
    
    def actos_individuales
      authorize! :contar, Sivel2Gen::Caso

      @rutacsv = File.join(Rails.root, 'public/somosdefensores/siaddhh/csv/actos_individuales.csv').to_s

      tarc = Tempfile.new(['actos_individuales', '.csv'], '/var/www/tmp/')
      rutatmp = tarc.path
      tarc.close
      tarc.unlink
      sql = "COPY (SELECT DISTINCT " \
        "caso.fecha, " \
        "supracategoria.tviolencia_id AS tviolencia_id," \
        "categoria.id AS categoria_id, " \
        "categoria.nombre AS categoria_nombre, " \
        "supracategoria.tviolencia_id || categoria.id || ' ' || categoria.nombre AS categoria_rotulo, " \
        "acto.presponsable_id AS presponsable_id, " \
        "presponsable.nombre AS presponsable, " \
        "ubicacion.departamento_id AS departamento_id, " \
        "ubicacion.municipio_id AS municipio_id, " \
        "departamento.nombre AS departamento, " \
        "municipio.nombre AS municipio, " \
        "COUNT(*) as cuenta " \
        "FROM sivel2_gen_acto AS acto " \
        "JOIN sivel2_gen_caso AS caso ON caso.id = acto.caso_id " \
        "JOIN sivel2_gen_categoria AS categoria ON categoria.id=acto.categoria_id " \
        "JOIN sivel2_gen_supracategoria AS supracategoria ON supracategoria.id = categoria.supracategoria_id " \
        "JOIN sivel2_gen_presponsable AS presponsable ON presponsable.id=acto.presponsable_id " \
        "LEFT JOIN msip_ubicacion AS ubicacion ON ubicacion.id=caso.ubicacion_id " \
        "LEFT JOIN msip_departamento AS departamento ON ubicacion.departamento_id=departamento.id " \
        "LEFT JOIN msip_municipio AS municipio ON ubicacion.municipio_id=municipio.id " \
        "GROUP BY 1,2,3,4,5,6,7,8,9,10,11) " \
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
      render 'fil23_gen/graficar_plotly/actos_individuales', 
        layout: 'application'
    end

  end

end
