class CreateVisualizationPaths < ActiveRecord::Migration
  def change
    create_table :visualization_paths do |t|
      t.integer :user_id
      t.string :name
      t.text :filter
      t.text :path
      t.timestamps
    end
  end
end
