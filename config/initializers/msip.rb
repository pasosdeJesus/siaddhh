require 'sivel2_gen/version'

Msip.setup do |config|
  config.ruta_anexos = ENV.fetch('SIP_RUTA_ANEXOS', 
                                 "#{Rails.root}/archivos/anexos")
  config.ruta_volcados = ENV.fetch('SIP_RUTA_VOLCADOS',
                                   "#{Rails.root}/archivos/bd")
  config.titulo = "#{ENV.fetch('SIP_TITULO', 'SIADDHH')} #{Sivel2Gen::VERSION}"

  config.colorom_fondo = '#f2d9d0'
  config.colorom_color_fuente = '#000000'
  config.colorom_nav_ini = '#f2a285'
  config.colorom_nav_fin = '#f24405'
  config.colorom_nav_fuente = '#ffffff'
  config.colorom_fondo_lista = '#f2a285'
  config.colorom_btn_primario_fondo_ini = '#f2a285'
  config.colorom_btn_primario_fondo_fin = '#f24405'
  config.colorom_btn_primario_fuente = '#ffffff'
  config.colorom_btn_peligro_fondo_ini = '#bf1b28'
  config.colorom_btn_peligro_fondo_fin = '#bf1b28'
  config.colorom_btn_peligro_fuente = '#ffffff'
  config.colorom_btn_accion_fondo_ini = '#f2f2ff'
  config.colorom_btn_accion_fondo_fin= '#d6d6f0'
  config.colorom_btn_accion_fuente = '#000000'
  config.colorom_alerta_exito_fondo = '#f2a285'
  config.colorom_alerta_exito_fuente = '#000000'
  config.colorom_alerta_problema_fondo = '#bf1b28'
  config.colorom_alerta_problema_fuente = '#ffffff'
end
