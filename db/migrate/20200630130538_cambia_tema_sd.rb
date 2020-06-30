class CambiaTemaSd < ActiveRecord::Migration[6.0]
  def up
    t=Sip::Tema.all.find(1)
    t.fondo = '#ffffff'
    t.color_flota_subitem_fondo = '#ffffff'
    t.save!
  end

  def down
    t=Sip::Tema.all.find(1)
    t.fondo = '#f2d9d0'
    t.color_flota_subitem_fondo = '#f2d9d0'
    t.save!
  end
end
