class ConvVictimadef < ActiveRecord::Migration[5.2]
  def up
    if !table_exists? :victimadef 
      return
    end
    # Informacion legada con maximo id_grupoper 52389
    execute <<-SQL
      INSERT INTO sip_actorsocial_persona (actorsocial_id, persona_id, 
        perfilactorsocial_id, created_at, updated_at)
        (SELECT id_grupoper, id_persona, CASE id_perfilorganizacion 
          WHEN 1 THEN 5 WHEN 5 THEN 1 ELSE id_perfilorganizacion END,
          NOW(), NOW() FROM victimadef);
      UPDATE sivel2_gen_victima SET 
        otraorganizacion=victimadef.otraorganizacion FROM victimadef WHERE 
        sivel2_gen_victima.id_persona=victimadef.id_persona AND 
        sivel2_gen_victima.id_caso=victimadef.id_caso;
    SQL
  end
  def down
    if !table_exists? :victimadef 
      return
    end
    execute <<-SQL
      UPDATE sivel2_gen_victima SET
        otraorganizacion=NULL FROM victimadef WHERE 
        sivel2_gen_victima.id_persona=victimadef.id_persona AND 
        sivel2_gen_victima.id_caso=victimadef.id_caso;
      DELETE FROM sivel2_gen_victima WHERE (actorsocial_id, persona_id, 
        perfilactorsocial_id) IN 
      (SELECT id_grupoper, id_persona, CASE id_perfilorganizacion 
          WHEN 1 THEN 5 WHEN 5 THEN 1 ELSE id_perfilorganizacion END
          FROM victimadef);
    SQL
  end
end
