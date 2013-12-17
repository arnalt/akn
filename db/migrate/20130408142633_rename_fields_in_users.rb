class RenameFieldsInUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :vorname,       :firstname
      t.rename :nachname,    :lastname
    end

  end
end
