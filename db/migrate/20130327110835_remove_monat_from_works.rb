class RemoveMonatFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :monat
  end
end
