class AddFieldsYearMonthToWork < ActiveRecord::Migration
  def change
    add_column :works, :year, :integer

    add_column :works, :month, :integer

  end
end
