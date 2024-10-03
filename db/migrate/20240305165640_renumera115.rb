class Renumera115 < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
     -- No se vieron actos con categoria 115
      UPDATE sivel2_gen_categoria SET id=10015 WHERE id=115;
    SQL
  end
  def down
    execute <<-SQL
      UPDATE sivel2_gen_categoria SET id=115 WHERE id=10015;
    SQL
  end
end
