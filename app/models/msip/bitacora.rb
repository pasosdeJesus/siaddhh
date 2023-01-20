
require 'msip/concerns/models/bitacora'

module Msip
  class Bitacora < ActiveRecord::Base
    include Msip::Concerns::Models::Bitacora

    scope :filtro_modelo, lambda { |t|
      where(modelo: t)
    }

    scope :filtro_usuario_id, lambda { |t|
      where(usuario_id: t)
    }

    scope :filtro_operacion, lambda { |t|
      where(operacion: t)
    }

    scope :filtro_modelo_id, lambda { |t|
      where(modelo_id: t)
    }

    scope :filtro_url, lambda { |t|
      where("unaccent(url) ILIKE '%' || unaccent(?) || '%'", t)
    }

    scope :filtro_ip, lambda { |t|
      where("unaccent(ip) ILIKE '%' || unaccent(?) || '%'", t)
    }

    scope :filtro_fecha, lambda { |f|
      where('CAST(fecha AS DATE) 
              = ?', 
            Msip::FormatoFechaHelper.
            fecha_local_estandar(f)
           )
    }
  end
end
