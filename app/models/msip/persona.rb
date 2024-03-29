require 'sivel2_gen/concerns/models/persona'

module Msip
  class Persona < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Persona

#    has_one :orgsocial_persona, foreign_key: "persona_id", validate: true, 
#      class_name: 'Msip::OrgsocialPersona'
    accepts_nested_attributes_for :orgsocial_persona, 
      :reject_if => :all_blank

  end
end
