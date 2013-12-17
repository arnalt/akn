class AddTskIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :task_id, :integer

  end
end
