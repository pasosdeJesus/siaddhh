class PrepMsip < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper
  def up
    # Hay un anexo_pkey en sivel2_gen_anexo_caso
    if existe_restricción_en_tabla_pg?("anexo_pkey", "sivel2_gen_anexo_caso")
      renombrar_restricción_pg(
        "sivel2_gen_anexo_caso", "anexo_pkey", "sivel2_gen_anexo_caso_pkey")
    end
  end

  def down
  end
end
