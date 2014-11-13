class ChangeMartialStatusToMaritalStatus < ActiveRecord::Migration
  def change
    rename_column :avant_data, :martial_status, :marital_status
  end
end
