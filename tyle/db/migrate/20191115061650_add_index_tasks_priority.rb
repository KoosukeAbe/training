class AddIndexTasksPriority < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, :priority
  end
end
