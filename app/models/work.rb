class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  belongs_to :task

  before_create :complete_work
  before_update :complete_work

  validates :date, :start_at, :end_at, :pause, :client_id, presence: true
  validates :date,  uniqueness:true

  def self.build_report(start_at,end_at,client_id)
     where("date >= ? and date <= ? and client_id = ?", start_at, end_at, client_id)
  end

  def self.build_works_by_task(task_id)
    where("task_id = ?", task_id )
  end

  def complete_work
    self.client_id = Task.find(self.task_id).client_id
    @arr = I18n.t("date.day_names")
    self.day = @arr.at(self.date.wday)
    self.week = ((self.date - self.date.at_beginning_of_year) / 7 + 0.8).round.to_i
    self.working_hours = ((((self.end_at.hour * 60) + self.end_at.min) - ((self.start_at.hour * 60) + self.start_at.min)) - ((self.pause.hour * 60) + self.pause.min)) / 60.0
  end

  def self.total_on(date,work)
   where("date = ? AND user_id = ? AND client_id = ? ", date, work.first.user_id, work.first.client_id ).sum(:working_hours)
  end

  def self.get_avg(start_at, end_at,client_id)
    self.build_report(start_at,end_at, client_id).average(:working_hours)
  end

  def self.get_min(start_at, end_at, client_id)
    self.build_report(start_at,end_at, client_id).minimum(:working_hours)
  end

  def self.get_max(start_at, end_at, client_id)
    self.build_report(start_at,end_at, client_id).maximum(:working_hours)
  end

  def self.get_days(start_at, end_at, client_id)
    self.build_report(start_at,end_at, client_id).count
  end
end
