class AddIndexTasksStatusId < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :status_id
  end
end
