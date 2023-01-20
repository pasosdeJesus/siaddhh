require 'sivel2_gen/concerns/models/victimacolectiva'

module Sivel2Gen
  class Victimacolectiva < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Victimacolectiva

    belongs_to :orgsocial, class_name: 'Msip::Orgsocial',
      foreign_key: 'orgsocial_id', validate: true, optional: true
    accepts_nested_attributes_for :orgsocial, reject_if: :all_blank

  end
end
