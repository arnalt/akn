class RenameFieldHoursToWorkingHours < ActiveRecord::Migration
  def change
    change_table :works do |t|
      t.rename :hours,       :working_hours
    end

  end
end
