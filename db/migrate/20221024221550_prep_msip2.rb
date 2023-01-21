class PrepMsip2 < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper
  def up
    if existe_restricción_en_tabla_pg?("regionsjr_pkey", "sip_oficina")
      renombrar_restricción_pg(
        "sip_oficina", "regionsjr_pkey", "sip_oficina_pkey")
    end
  end
  def down
  end
end
