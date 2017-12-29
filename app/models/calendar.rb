class Calendar < ActiveRecord::Base

  def self get_wochentag(datum)
    where ('datum = ?',wochentage)
  end
end
