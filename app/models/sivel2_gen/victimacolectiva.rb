# encoding: UTF-8

require 'sivel2_gen/concerns/models/victimacolectiva'

module Sivel2Gen
  class Victimacolectiva < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Victimacolectiva

    belongs_to :actorsocial, class_name: 'Sip::Actorsocial',
      foreign_key: 'actorsocial_id', validate: true
    accepts_nested_attributes_for :actorsocial, reject_if: :all_blank

  end
end
