class CreateDeletedTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :deleted_tasks do |t|
      t.string :title, limit: 100, :null => false
      t.text :description, limit: 255
      t.integer :importance, :null => false
      t.date :due_date, :null => false

      t.timestamps
    end
  end
end
