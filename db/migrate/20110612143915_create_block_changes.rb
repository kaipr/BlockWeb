class CreateBlockChanges < ActiveRecord::Migration
  def change
    create_table :block_changes do |t|

      t.timestamps
    end
  end
end
