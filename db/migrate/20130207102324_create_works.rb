class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.date :datum
      t.integer :kw
      t.string :tag
      t.time :von
      t.time :bis
      t.time :mm
      t.decimal :std
      t.string :pbez
      t.string :kunde
      t.text :erl

      t.timestamps
    end
  end
end
