class RemoveKundeFromWorks < ActiveRecord::Migration
  def change
     remove_column :works, :pbez
    remove_column :works, :kunde
  end

end
