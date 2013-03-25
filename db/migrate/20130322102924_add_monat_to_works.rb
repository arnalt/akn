class AddMonatToWorks < ActiveRecord::Migration
  def change
    add_column :works, :monat, :integer

  end
end
