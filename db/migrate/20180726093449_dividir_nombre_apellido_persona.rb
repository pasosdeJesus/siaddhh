class DividirNombreApellidoPersona < ActiveRecord::Migration[5.2]
  def up
    # Se vieron 2882 personas cuyo campo apellidos estaba vacio
    execute <<-SQL
      WITH pd AS (SELECT id, 
        regexp_split_to_array(trim(nombres), E'\\\\s+') AS nd FROM sip_persona), 
        pna AS (SELECT sip_persona.id, CASE cardinality(nd) 
          WHEN 0 THEN ARRAY['N', 'N'] 
          WHEN 1 THEN ARRAY[nd[1],'N'] 
          WHEN 2 THEN ARRAY[nd[1],nd[2]] 
          WHEN 3 THEN ARRAY[nd[1], nd[2] || ' ' || nd[3]] 
          ELSE ARRAY[nd[1] || ' ' || nd[2], array_to_string(nd[3:], ' ')] 
        END AS nna FROM sip_persona JOIN pd ON pd.id=sip_persona.id) 
      UPDATE sip_persona
      SET nombres=pna.nna[1], apellidos=pna.nna[2]
      FROM pna WHERE sip_persona.id=pna.id AND sip_persona.apellidos='';
    SQL
  end
  def down

  end
end
