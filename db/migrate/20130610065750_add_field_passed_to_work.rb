class AddFieldPassedToWork < ActiveRecord::Migration
  def change
    add_column :works, :passed, :boolean

  end
end
