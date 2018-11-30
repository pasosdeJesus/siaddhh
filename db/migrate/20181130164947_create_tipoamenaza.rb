class CreateTipoamenaza < ActiveRecord::Migration[5.2]
  def up
    create_table :tipoamenaza do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    execute <<-SQL
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (1, 'PANFLETO', '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (2, 'LLAMADA FIJO/CELULAR', '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (3, 'CORREO ELECTRÓNICO', '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (4, 'REDES SOCIALES', '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (5, 'MENSAJE DE TEXTO', '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (6, 'ASESINATO-ATENTADO DE FAMILIAR', 
        '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (7, 'HOSTIGAMIENTO (PERSECUCIÓN PERSONAS EXTRAÑAS - FOTOGRAFÍAS)', 
        '2018-11-30', now(), now());
      INSERT INTO tipoamenaza (id, nombre, 
        fechacreacion, created_at, updated_at)
        VALUES (8, 'HOSTIGAMIENTO (AMENAZAS CON ARMA Y/O VERBALES)', 
        '2018-11-30', now(), now());
      SELECT setval('tipoamenaza_id_seq', 101, true);
    SQL
  end
  def down
    drop_table :tipoamenaza
  end
end
