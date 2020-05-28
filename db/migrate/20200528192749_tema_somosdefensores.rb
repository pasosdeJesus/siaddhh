class TemaSomosdefensores < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
    UPDATE public.sip_tema SET 
      nombre='INSTITUCIONAL SOMOS DEFENSORES',
      colorom_fondo = '#f2d9d0',
      color_fuente = '#000000',
      nav_ini = '#f2a285',
      nav_fin = '#f24405',
      nav_fuente = '#ffffff',
      fondo_lista = '#f2a285',
      btn_primario_fondo_ini = '#f2a285',
      btn_primario_fondo_fin = '#f24405',
      btn_primario_fuente = '#ffffff',
      btn_peligro_fondo_ini = '#bf1b28',
      btn_peligro_fondo_fin = '#bf1b28',
      btn_peligro_fuente = '#ffffff',
      btn_accion_fondo_ini = '#f2f2ff',
      btn_accion_fondo_fin= '#d6d6f0',
      btn_accion_fuente = '#000000',
      alerta_exito_fondo = '#f2a285',
      alerta_exito_fuente = '#000000',
      alerta_problema_fondo = '#bf1b28',
      alerta_problema_fuente = '#ffffff',
      WHERE id=1;
    SQL

  end

  def down
  end
end
