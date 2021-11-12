class CodmunOpcional < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      DROP MATERIALIZED VIEW IF EXISTS sip_mundep;
      DROP VIEW IF EXISTS sip_mundep_sinorden;
    SQL
    change_column :sip_municipio, :id_munlocal, :integer, null: true
  end
  def down
    change_column :sip_municipio, :id_munlocal, :integer, null: false
  end
end
