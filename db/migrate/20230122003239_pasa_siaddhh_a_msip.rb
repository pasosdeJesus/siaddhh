class PasaSiaddhhAMsip < ActiveRecord::Migration[7.0]
  def up
    rename_table :sip_tipoanexo, :msip_tipoanexo
  end

  def down
    rename_table :msip_tipoanexo, :sip_tipoanexo
  end
end
