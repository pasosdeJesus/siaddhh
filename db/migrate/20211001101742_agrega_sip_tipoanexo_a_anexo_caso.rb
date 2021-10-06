class AgregaSipTipoanexoAAnexoCaso < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_gen_anexo_caso, :tipoanexo_id, :integer
    add_foreign_key :sivel2_gen_anexo_caso, :sip_tipoanexo, column: :tipoanexo_id
  end
end
