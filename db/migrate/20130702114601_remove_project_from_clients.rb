class RemoveProjectFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :project
  end

end
