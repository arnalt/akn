class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :personnel_number, :integer

    add_column :users, :annual_hours, :integer

  end
end
