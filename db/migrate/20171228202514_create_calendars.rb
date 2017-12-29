class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :datum
      t.integer :wochentage
      t.integer :jahr
      t.integer :arbeitstag
      t.decimal :stunden

      t.timestamps
    end
  end
end
