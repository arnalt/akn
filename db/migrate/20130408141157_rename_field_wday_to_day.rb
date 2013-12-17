class RenameFieldWdayToDay < ActiveRecord::Migration
  def change
    change_table :works do |t|
      t.rename :wday,       :day
      t.rename :std,            :hours
  end

end
end
