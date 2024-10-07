class RenumeraOrg < ActiveRecord::Migration[7.2]

  def renumera_ref_organizacion(id_ant, id_nuevo)
    execute <<-SQL
        UPDATE sivel2_gen_victima
          SET organizacion_id='#{id_nuevo}' WHERE organizacion_id=#{id_ant};
        UPDATE sivel2_gen_otraorga_victima
          SET organizacion_id='#{id_nuevo}' WHERE organizacion_id=#{id_ant};
        UPDATE sivel2_gen_combatiente
          SET organizacion_id='#{id_nuevo}' WHERE organizacion_id=#{id_ant};
        UPDATE sivel2_gen_organizacion_victimacolectiva
          SET organizacion_id='#{id_nuevo}' WHERE organizacion_id=#{id_ant};
      SQL
  end

  def up
    execute <<-SQL
      UPDATE sivel2_gen_organizacion SET nombre=nombre || ' ¿' WHERE
        id IN (19,21,22,23);
      INSERT INTO sivel2_gen_organizacion (id, nombre, 
        fechacreacion, created_at, updated_at) VALUES
        (119, 'ACOMPAÑAMIENTO INTERNAL',
        '2024-10-07', '2024-10-07', '2024-10-07');
      INSERT INTO sivel2_gen_organizacion (id, nombre, 
        fechacreacion, created_at, updated_at) VALUES
        (121, 'MEDIOS COMUNICACION',
        '2024-10-07', '2024-10-07', '2024-10-07');
      INSERT INTO sivel2_gen_organizacion (id, nombre, 
        fechacreacion, created_at, updated_at) VALUES
        (122, 'MOVIMIENTO POLITICO',
        '2024-10-07', '2024-10-07', '2024-10-07');
      INSERT INTO sivel2_gen_organizacion (id, nombre, 
        fechacreacion, created_at, updated_at) VALUES
        (123, 'COMUNITARIA',
        '2024-10-07', '2024-10-07', '2024-10-07');
    SQL
    renumera_ref_organizacion(19, 119)
    renumera_ref_organizacion(21, 121)
    renumera_ref_organizacion(22, 122)
    renumera_ref_organizacion(23, 123)
    execute <<-SQL
      DELETE FROM sivel2_gen_organizacion WHERE id IN (19,21,22,23);
    SQL
  end
  
  def down
  end
end
