require 'sivel2_gen/concerns/models/anexo_caso'

module Sivel2Gen
  class AnexoCaso < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::AnexoCaso
    belongs_to :tipoanexo, class_name: 'Sip::Tipoanexo',
      foreign_key: 'tipoanexo_id', optional: true
  end
end
