class RenameAttributesInWorks < ActiveRecord::Migration
  def change
    change_table :works do |t|
      t.rename :datum, :date
      t.rename :kw,        :week
      t.rename :tag,       :wday
      t.rename :von,      :start_at
      t.rename :bis,        :end_at
      t.rename :mm,      :pause
      t.rename :erl,         :description
   end
  end
end
