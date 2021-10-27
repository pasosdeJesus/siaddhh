module Fil23Gen
  class Bifurcacion < ActiveRecord::Base
    self.table_name = 'fil23_gen_bifurcacion'
    validates :numproc, presence: true
    validates :marcatemporal, presence: true
  end
end
