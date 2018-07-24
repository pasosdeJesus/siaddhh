class VictimacoldefAActorsocial < ActiveRecord::Migration[5.2]
  def up
    if table_exists? :victimacoldef
      execute <<-SQL
        INSERT INTO sip_actorsocial (id, grupoper_id, fechafundacion, created_at,
          updated_at) (SELECT id_grupoper, id_grupoper, min(fechafundacion), 
            now(), now() FROM victimacoldef group by 1 order by 1);
        UPDATE sivel2_gen_victimacolectiva SET actorsocial_id=id_grupoper
          WHERE id_grupoper IN (SELECT DISTINCT id_grupoper FROM victimacoldef);
      SQL
    end
  end
  def down
    if table_exists? :victimacoldef
      execute <<-SQL
        UPDATE sivel2_gen_victimacolectiva SET actorsocial_id=NULL
          WHERE id_grupoper IN (SELECT DISTINCT id_grupoper FROM victimacoldef);
        DELETE FROM sip_actorsocial WHERE 
        id IN (SELECT grupoper_id FROM victimacoldef);
      SQL
    end
  end
end
