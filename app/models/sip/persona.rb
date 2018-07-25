# encoding: UTF-8

require 'sivel2_gen/concerns/models/persona'

module Sip
  class Persona < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Persona

    has_one :actorsocial_persona, foreign_key: "persona_id", validate: true, 
      class_name: 'Sip::ActorsocialPersona'
    accepts_nested_attributes_for :actorsocial_persona, :reject_if => :all_blank

  end
end
