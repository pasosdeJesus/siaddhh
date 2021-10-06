include Sip::MigracionHelper
class CreateTipoanexo < ActiveRecord::Migration[6.1]
  def up
    create_table :sip_tipoanexo do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamps
    end
    cambiaCotejacion('sip_tipoanexo', 'nombre', 500, 'es_co_utf_8')
  end

  def down
    drop_table :sip_tipoanexo
  end
end
