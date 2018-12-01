class AgregaTipoamenazaVictima < ActiveRecord::Migration[5.2]
  def change
    add_column :sivel2_gen_victima, :tipoamenaza_id, :integer
    add_foreign_key :sivel2_gen_victima, :tipoamenaza
  end
end
