class Calendar < ActiveRecord::Base

  def self.get_kaltag(datum)
    where (datum = ?, kaltag)
  end

end
