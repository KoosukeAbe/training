class CreateColumnLimit < ActiveRecord::Migration[6.1]
  def change
    create_table :column_limits do |t|

      t.timestamps
    end
  end
end
