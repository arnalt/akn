class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :client

  before_create :complete_work
  before_update :complete_work

  validates :datum, :von, :bis, :mm, :client_id, presence: true

  def self.build_report(von,bis,clientname)
    where("datum >= ? AND datum <= ? and client_id = ?", von, bis, Client.find_all_by_name(clientname))
  end


  def complete_work
    @arr = I18n.t("date.day_names")
    self.tag = @arr.at(self.datum.wday)
    self.kw = ((self.datum - self.datum.at_beginning_of_year) / 7 + 0.8).round.to_i
    self.std = ((((self.bis.hour * 60) + self.bis.min) - ((self.von.hour * 60) + self.von.min)) - ((self.mm.hour * 60) + self.mm.min)) / 60.0
  end

end
