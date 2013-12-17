class RemoveClientIdFrom < ActiveRecord::Migration
  def change
    remove_column :tasks, :client_id
  end

end
