class SinObsoletoFuncionario < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      ALTER TABLE sivel2_gen_caso_usuario
        DROP CONSTRAINT IF EXISTS funcionario_caso_id_funcionario_fkey;
    SQL
  end
  def down
  end
end
