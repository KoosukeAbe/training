class RemoveLabelIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :label_id, :integer
  end
end
