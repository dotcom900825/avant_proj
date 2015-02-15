class AddLatLongToAvantData < ActiveRecord::Migration
  def change
    add_column :avant_data, :lat, :string
    add_column :avant_data, :long, :string
  end
end
