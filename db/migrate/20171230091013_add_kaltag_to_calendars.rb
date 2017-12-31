class AddKaltagToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :kaltag, :integer

  end
end
