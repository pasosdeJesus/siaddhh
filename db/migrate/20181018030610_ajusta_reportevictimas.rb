class AjustaReportevictimas < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      UPDATE sivel2_gen_pconsolidado SET rotulo='ASESINATO' where id=1;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=1 WHERE
        id_pconsolidado IN (2,3);
      UPDATE sivel2_gen_pconsolidado SET rotulo='DESAPARICIÓN FORZADA' 
        WHERE id=7;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=7 WHERE
        id_pconsolidado IN (4, 5);
      UPDATE sivel2_gen_pconsolidado SET rotulo='HERIDA' 
        WHERE id=5;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=5 WHERE
        id_pconsolidado IN (9, 10, 11);
      UPDATE sivel2_gen_pconsolidado SET rotulo='AMENAZA' where id=2;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=2 WHERE
        id_pconsolidado IN (13,14,15);
      UPDATE sivel2_gen_pconsolidado SET rotulo='ATENTADO' where id=3;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=3 WHERE
        id_pconsolidado IN (16,17);
      UPDATE sivel2_gen_pconsolidado SET rotulo='DETENCIÓN ARBITRARIA' 
        WHERE id=4;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=4 WHERE
        id_pconsolidado IN (12);
      UPDATE sivel2_gen_categoria SET id_pconsolidado=4
        WHERE id IN (14, 24, 301);
      UPDATE sivel2_gen_categoria SET id_pconsolidado=5
        WHERE id IN (13,23,33,88,98,702,704,43,53);
      UPDATE sivel2_gen_pconsolidado SET rotulo='USO IND. SISTEMA PENAL' 
        WHERE id=6;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=6 WHERE
        id_pconsolidado IN (18, 19);
     UPDATE sivel2_gen_pconsolidado SET rotulo='VIOLENCIA SEXUAL' 
        WHERE id=8;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=8 WHERE
        id_pconsolidado IN (20, 21, 22);
      UPDATE sivel2_gen_pconsolidado SET rotulo='HURTO' 
        WHERE id=9;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=9 WHERE
        id IN (95);
      UPDATE sivel2_gen_pconsolidado SET rotulo='DESPLAZAMIENTO FORZADO' 
        WHERE id=10;
      UPDATE sivel2_gen_pconsolidado SET rotulo='OTROS' 
        WHERE id=11;
      UPDATE sivel2_gen_categoria SET id_pconsolidado=11 
        WHERE id_pconsolidado>11;
      DELETE FROM sivel2_gen_pconsolidado WHERE id>11;
    SQL
  end
end
