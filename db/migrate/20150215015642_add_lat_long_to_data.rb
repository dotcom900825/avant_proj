class AddLatLongToData < ActiveRecord::Migration
  def change
    add_column :sdtj_demos, :lat, :string
    add_column :sdtj_demos, :long, :string
  end
end
