class AddClientIdToWorks < ActiveRecord::Migration
  def change
    add_column :works, :client_id, :integer

  end
end
