# encoding: UTF-8

class GraficarjsController < ApplicationController

  def d3_victimizaciones_por_sexo
    authorize! :contar, Sivel2Gen::Caso

    #res = ActiveRecord::Base.connection.execute(sql)
    render :d3_vs, layout: 'application'
    return
  end

  def plotly_victimizaciones_por_sexo
    authorize! :contar, Sivel2Gen::Caso

    #res = ActiveRecord::Base.connection.execute(sql)
    render :plotly_vs, layout: 'application'
    return
  end

  def chartjs_victimizaciones_por_sexo
    authorize! :contar, Sivel2Gen::Caso

    #res = ActiveRecord::Base.connection.execute(sql)
    render :chartjs_vs, layout: 'application'
    return
  end


end
