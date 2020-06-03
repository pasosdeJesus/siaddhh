class CreaFil23Bifurcacion < ActiveRecord::Migration[6.0]
  def change
    create_table :fil23_gen_bifurcacion do |t|
      t.timestamp :marcatemporal
      t.integer :numproc
    end
  end
end
