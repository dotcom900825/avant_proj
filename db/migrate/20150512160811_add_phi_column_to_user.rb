class AddPhiColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :phi_role, :integer, :default=>0
  end
end
