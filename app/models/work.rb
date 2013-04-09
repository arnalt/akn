class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :client

  before_create :complete_work
  before_update :complete_work

  validates :date, :start_at, :end_at, :pause, :client_id, presence: true

  def self.build_report(start_at,end_at,clientname)
    where("date >= ? AND date <= ? and client_id = ?", start_at, end_at, Client.find_all_by_name(clientname))
  end


  def complete_work
    @arr = I18n.t("date.day_names")
    self.day = @arr.at(self.date.wday)
    self.week = ((self.date - self.date.at_beginning_of_year) / 7 + 0.8).round.to_i
    self.working_hours = ((((self.end_at.hour * 60) + self.end_at.min) - ((self.start_at.hour * 60) + self.start_at.min)) - ((self.pause.hour * 60) + self.pause.min)) / 60.0
  end

end
