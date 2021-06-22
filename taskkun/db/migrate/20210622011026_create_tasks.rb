class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 100, :null => false
      t.text :description, limit: 255
      t.integer :importance, :null => false
      t.date :due_date, :null => false
      t.integer :user_id, :null => false
      t.integer :status_id, :null => false
      t.integer :label_id, :null => false
      t.boolean :is_deleted, :null => false, :default => 'true'

      t.timestamps
    end
  end
end
