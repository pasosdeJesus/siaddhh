# encoding: UTF-8

require 'sivel2_gen/concerns/models/victima'

module Sivel2Gen
  class Victima < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Victima

    validates :otraorganizacion, length: { maximum: 500 }
    belongs_to :tipoamenaza, class_name: '::Tipoamenaza',
      foreign_key: 'tipoamenaza_id'

    def presenta(atr)
      case atr.to_s
      when 'perfilliderazgo'
        self.profesion ? self.profesion.nombre : ''
      when 'colectivohumano'
        if self.persona && self.persona.actorsocial_persona &&
            self.persona.actorsocial_persona.actorsocial_id &&
            self.persona.actorsocial_persona.actorsocial.grupoper_id
          return self.persona.actorsocial_persona.actorsocial.grupoper.nombre
        end
        return ''
      when /tamenaza[0-9]+/
        num=atr.to_s[8..-1].to_i
        ti = Tipoamenaza.all.order(:id)
        if num < ti.count  && 
            self.tipoamenaza && self.tipoamenaza.id == ti[num].id
          return 1
        end
        return ''
      else
        sivel2_gen_victima_presenta(atr)
      end
    end
  end
end
