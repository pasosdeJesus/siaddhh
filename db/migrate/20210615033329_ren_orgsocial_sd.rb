class RenOrgsocialSd < ActiveRecord::Migration[6.1]
  def change
    rename_column :sivel2_gen_victimacolectiva, :actorsocial_id, :orgsocial_id
  end
end
