class RemoveTaskIdFromClient < ActiveRecord::Migration
  def change
    remove_column :clients, :task_id
  end
end
