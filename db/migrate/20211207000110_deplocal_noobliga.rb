class DeplocalNoobliga < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      DROP VIEW IF EXISTS cben2;
    SQL
    change_column :sip_departamento, :id_deplocal, :integer, null: true
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS cben2;
    SQL
    change_column :sip_departamento, :id_deplocal, :integer, null: false
  end
end
