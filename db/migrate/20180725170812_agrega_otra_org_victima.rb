class AgregaOtraOrgVictima < ActiveRecord::Migration[5.2]
  def change
    add_column :sivel2_gen_victima, :otraorganizacion, :string, limit: 500
  end
end
