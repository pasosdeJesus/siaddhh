class DatosiniSipTipoanexo < ActiveRecord::Migration[6.1]
 def up
    execute <<-SQL
      INSERT INTO sip_tipoanexo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)    
        VALUES (1,'SIN INFORMACION', '', '2021-10-01', NULL, '2021-10-01', '2021-10-01');
      INSERT INTO sip_tipoanexo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)    
        VALUES (2,'FOTO DE VÍCTIMA', '', '2021-10-01', NULL, '2021-10-01', '2021-10-01');
        SELECT setval('sip_tipoanexo_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM sip_tipoanexo WHERE id>=1 AND id<=2;
    SQL
  end
end
