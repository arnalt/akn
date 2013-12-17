class AddClientIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :client_id, :integer

  end
end
