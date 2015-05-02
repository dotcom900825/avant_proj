class CreateWifiData < ActiveRecord::Migration
  def change
    create_table :wifi_data do |t|
      t.float :time
      t.string :source
      t.string :destination
      t.string :protocol
      t.integer :length
      t.text :info
    end
  end
end
