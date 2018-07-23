class ColectivasSonActorSocial < ActiveRecord::Migration[5.2]
  def change
    add_column :sivel2_gen_victimacolectiva, :actorsocial_id, :integer
    add_foreign_key :sivel2_gen_victimacolectiva, :sip_actorsocial, 
      column: :actorsocial_id
    add_column :sip_actorsocial, :fechafundacion, :date
  end
end
